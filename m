Return-Path: <linux-kernel+bounces-241347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 058E4927A05
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32F861C24083
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E061C1B121C;
	Thu,  4 Jul 2024 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e8dtpcal"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA031B120E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720106967; cv=none; b=ka3asLWCrH8hsa18kSVBEWUEHfsrGfoorsiH5MuSuUDOQKCokmbcdPbp9CRNHAf7LpuwFpCsI7DvveIGieQeqtBgANhihDx1HTcg82agoJQcjMXDza4mD8lANIu3YjhLEkO8drPH+yLk+UpixXsbhebb7e0iLP6LeUdCHA3PO/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720106967; c=relaxed/simple;
	bh=P76FYceHrJYP3VHRuG3OJOpUDhLADam7CDPSRK6G1uA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WGjf7VN7ADEDJYb0zwJ1Ix7yzo2LfuJ91OqC8Amkjo71H0Ok4/JChYjyOhGMlr88DL7hOsp0KlbV4AyVhIHGJjAdDD1c+q5t5Mwgak/J9IMoI0Odhxma6XGLW3rQpZTdb+q1UxnJ9JifG0qtb7sxl61GbCOvHYeWW4NQzy2qlJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e8dtpcal; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720106964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VMo09GIbeWWei76D143X+Swf4hFzKnjD2EXCX4KLGFs=;
	b=e8dtpcal+uYdoNBH6RdXrmWolkgSCaHT5cEbLOv530Gk0VpSxDYhz44JDWDXJRaA/Pq1eT
	DQdo1EY0trnxDFVNcyBe6JXRbub8cgiOgjMqQVE7ddZX90bwhjeD1huMqW8GgmspRgx8/C
	hIPh5uLXlQY8eiHivSwf/kBjK10bGQs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-wXl8dIxCNLSLp0e58Hk67w-1; Thu,
 04 Jul 2024 11:29:21 -0400
X-MC-Unique: wXl8dIxCNLSLp0e58Hk67w-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D007196CE02;
	Thu,  4 Jul 2024 15:29:20 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D0503195605A;
	Thu,  4 Jul 2024 15:29:19 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id B3EF730C1C14; Thu,  4 Jul 2024 15:29:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id B163D3FB52;
	Thu,  4 Jul 2024 17:29:18 +0200 (CEST)
Date: Thu, 4 Jul 2024 17:29:18 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Li Dong <lidong@vivo.com>
cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
    "open list:DEVICE-MAPPER  (LVM)" <dm-devel@lists.linux.dev>, 
    open list <linux-kernel@vger.kernel.org>, opensource.kernel@vivo.com
Subject: Re: [PATCH] dm-table:fix zone block_device not aligned with
 zonesize
In-Reply-To: <20240704151549.1365-1-lidong@vivo.com>
Message-ID: <cd05398-cffa-f4ca-2ac3-74433be2316c@redhat.com>
References: <20240704151549.1365-1-lidong@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40



On Thu, 4 Jul 2024, Li Dong wrote:

> For zone block devices, device_area_is_invalid may return an incorrect 
> value.
> 
> Failure log:
> [   19.337657]: device-mapper: table: 254:56: len=836960256 not aligned to
> h/w zone size 3244032 of sde
> [   19.337665]: device-mapper: core: Cannot calculate initial queue limits
> [   19.337667]: device-mapper: ioctl: unable to set up device queue for 
> new table.
> 
> Actually, the device's zone length is aligned to the zonesize.
> 
> Fixes: 5dea271b6d87 ("dm table: pass correct dev area size to device_area_is_valid")
> Signed-off-by: Li Dong <lidong@vivo.com>
> ---
>  drivers/md/dm-table.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 33b7a1844ed4..0bddae0bee3c 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -257,7 +257,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
>  	if (bdev_is_zoned(bdev)) {
>  		unsigned int zone_sectors = bdev_zone_sectors(bdev);
>  
> -		if (start & (zone_sectors - 1)) {
> +		if (start % zone_sectors) {
>  			DMERR("%s: start=%llu not aligned to h/w zone size %u of %pg",
>  			      dm_device_name(ti->table->md),
>  			      (unsigned long long)start,
> @@ -274,7 +274,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
>  		 * devices do not end up with a smaller zone in the middle of
>  		 * the sector range.
>  		 */
> -		if (len & (zone_sectors - 1)) {
> +		if (len % zone_sectors) {
>  			DMERR("%s: len=%llu not aligned to h/w zone size %u of %pg",
>  			      dm_device_name(ti->table->md),
>  			      (unsigned long long)len,
> -- 
> 2.31.1.windows.1

Hi

This probably won't compile on 32-bit architectures because the operators 
for 64-bit divide and modulo don't work there.

Please, rework the patch using dm_sector_div64.

Mikulas


