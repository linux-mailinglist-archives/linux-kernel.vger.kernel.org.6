Return-Path: <linux-kernel+bounces-335898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EE197EC3B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3B972819FD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175A81993BB;
	Mon, 23 Sep 2024 13:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FXuZGyHF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018771990DE
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 13:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727098028; cv=none; b=VFU88irmJNrVrfHHND7+QqKal8WFt53edA1tHN9FI0Vmw8vVvcApaVU9KycSfQBBGQ/eVRB/UDrMOUIpXSTP4ZJPzWIAdDILyl7kHS4yP7FgqJPbFP4ZC6k5XmLuzNefPDpuYzZT/uJe39vm7o/8AeAYu4ba3VIlDRcN0IteF3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727098028; c=relaxed/simple;
	bh=dI2jexkoav3yhz6acugRW9+a907CmM5inGbCMhqpRXo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PHi93LNJ9VI+UB6qPrACsAIncpHl+kFCMVDErSyHlSXXXnIqEFe7rQstiAzzaeMXeNtO8uSI6aqaw9uCDVrXqsArHLCl9woE23XEXb6QyaQOINbqnI/5e/OHAXKfk9qNvXbwREyEg1tAq9xz5f18AV00zd6hr+/8X6CB1AJ2mq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FXuZGyHF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727098025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uxrw8H9RJR3IFfbc3l75F3IOlJFRvDC/cWL5VOkjHL0=;
	b=FXuZGyHFXWZGQZ0HbsglXTDVO+Mq5OFRruEBp41NEOP9UOV/sbjgADJHQSiiG3IWcBslAt
	wXLeF5jo0+NvCYQWNBLx+YeXkqg4m7qnggZNPXdLJe/2yddNX9MLzTKD1stQXXCZlGn5k1
	dA700CgdvO63fLTZYfVR5+kcV532hdk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-BHMPsk0nOumgYKwG6ROz5A-1; Mon,
 23 Sep 2024 09:27:02 -0400
X-MC-Unique: BHMPsk0nOumgYKwG6ROz5A-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 58DC718FFA5C;
	Mon, 23 Sep 2024 13:27:00 +0000 (UTC)
Received: from [10.45.226.79] (unknown [10.45.226.79])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC39619560AA;
	Mon, 23 Sep 2024 13:26:58 +0000 (UTC)
Date: Mon, 23 Sep 2024 15:26:56 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Dipendra Khadka <kdipendra88@gmail.com>
cc: agk@redhat.com, snitzer@kernel.org, dm-devel@lists.linux.dev, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Return error code for failure input for sscanf in
 parse_cblock_range()
In-Reply-To: <20240922164702.49615-1-kdipendra88@gmail.com>
Message-ID: <5c258e04-10b4-749d-6f15-94a432ab652e@redhat.com>
References: <20240922164702.49615-1-kdipendra88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi

I skimmed through the sscanf source code and it seems that it can't return 
a negative value at all.

I think, this should be:
	r = sscanf(str, "%llu-%llu%c", &b, &e, &dummy);
	if (r != 2)
		return -EINVAL;

Mikulas

On Sun, 22 Sep 2024, Dipendra Khadka wrote:

> Smatch reported following:
> '''
> drivers/md/dm-cache-target.c:3204 parse_cblock_range() warn: sscanf doesn't return error codes
> drivers/md/dm-cache-target.c:3217 parse_cblock_range() warn: sscanf doesn't return error codes
> '''
> 
> Since, the only negative value that is returned by sscanf is -1.
> Returning -ENVAL when sscanf returns -1.
> 
> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
> ---
>  drivers/md/dm-cache-target.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
> index 17f0fab1e254..c35d65e310d6 100644
> --- a/drivers/md/dm-cache-target.c
> +++ b/drivers/md/dm-cache-target.c
> @@ -3200,8 +3200,8 @@ static int parse_cblock_range(struct cache *cache, const char *str,
>  	 * Try and parse form (ii) first.
>  	 */
>  	r = sscanf(str, "%llu-%llu%c", &b, &e, &dummy);
> -	if (r < 0)
> -		return r;
> +	if (r == -1)
> +		return -EINVAL;
>  
>  	if (r == 2) {
>  		result->begin = to_cblock(b);
> @@ -3213,8 +3213,8 @@ static int parse_cblock_range(struct cache *cache, const char *str,
>  	 * That didn't work, try form (i).
>  	 */
>  	r = sscanf(str, "%llu%c", &b, &dummy);
> -	if (r < 0)
> -		return r;
> +	if (r == -1)
> +		return -EINVAL;
>  
>  	if (r == 1) {
>  		result->begin = to_cblock(b);
> -- 
> 2.43.0
> 


