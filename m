Return-Path: <linux-kernel+bounces-229515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B69091705E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A4771C25387
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897E0179206;
	Tue, 25 Jun 2024 18:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z0im+Bxi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1AB17C7B4
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 18:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719340650; cv=none; b=eImZHeHhMjpMx1ydmbNl/A4Q8LAQfn9yLgUKh+2qf8qe+dhm4VOMOdMwaJ7CtOsGNBwTBPOybKVESFfLWEde22AENSj5p4ZoyY+tyovSVqp0A8DYwSCpht3xBjmH85wuFKtOjEdPXxsQ8Ok2sLe3IYJGw6B2nKVIXeHGVP6Gdpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719340650; c=relaxed/simple;
	bh=xaBiOUCcbhsEiDDlr9ft/ApwQ3CgJk9n92ap/EN2vY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bErttaMTCLkyZaG2LU5Ic/sLJiaLOk6xrq+TV7bopDksKFQfJtteS+mBoqtSdU+mloVX98n1Q7kNNNyZ9aU7VscOH+oKoLENSQCjYTInnNUKNVFQVzL/BIG5IzXN6Ic8y5NOceqHbkrsyJ+k9NYvc0hQKWUmcLA1e0nhY0Z4Mqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z0im+Bxi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719340648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rjP8zqa9DjMRaFNMcMFYFsi4VJ9TPziW2E5FbrHXUKo=;
	b=Z0im+BxitRMpa3efI7Gc4GXDv6uxULwyAdkPmaMCbIq7S0H5uiVARBoEQnp4tnmEol2cJv
	HDFAdCHpDWzOTZPslsqLVMtzF6VTHEiCwy0W/IbWrPMf6uimpMctrlUVpI9RMYoqM1VAle
	yRRCFJqTg4iH789GEktvq9NaNX+hD2w=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-L-8Hp2u8NACDbRsmZqYdSg-1; Tue, 25 Jun 2024 14:37:26 -0400
X-MC-Unique: L-8Hp2u8NACDbRsmZqYdSg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7955f448a2dso924462985a.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 11:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719340646; x=1719945446;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rjP8zqa9DjMRaFNMcMFYFsi4VJ9TPziW2E5FbrHXUKo=;
        b=ozhISPuY0j5Y4TG1y3dZrlBvtcRS3duQCkRq6BARSyZubp8Lsi9HZ8+uTHHLNSqsVk
         SlvOKqf8MCdcT02oRkk0jc8GA3GpHa7KrUwhI+wD3rorkJBK9IS+/syy+ENgiGFZGKNs
         8BqMEMJgchg5zthy1ZblyM01qWy2qiOc+lT5VcSuHP8V2vW/9T1JFZv8uQFdpTN9p6vU
         KEWAdRspnRRrqmvzSO+f10ooTK89WRfd+oEvcpLOTvWXGGuALDo18MxGsVBsB2kqn08G
         A/t5qdgNU38VRJsrDwT4U7h/KVrK4ISVOTR7g9TI5WuR+N5E/pyD/Gb1vn2TFecYed60
         uNCA==
X-Forwarded-Encrypted: i=1; AJvYcCWukJmnBZ0JInC2X41mSjj/usMzQMGpJk1UH9bC4P6n49iDpbcPb5psOurmcQ3KcK9F5kiR6qIK4XN7/UA0dG4NbJzK8sKkimPP0cDR
X-Gm-Message-State: AOJu0YzZBvsdDhHh4/TlagE4uWgFTq9mwmJXtT6/9W6QyXY6mK4ChqV9
	BMLk8AWIkbzlKCCrBxQUW3eVlKf9QfOHckEbtPTwTf/7c+g0b6195PTNCx2u/cFizW87/w5P4h8
	Eu3sWSMEB3nkCC3Go6oB/kfrKWDUPsZQ/VqNfTk4xFSE5U+i8LKjYEjvimOhMIQ==
X-Received: by 2002:a05:620a:838b:b0:797:9c76:32a6 with SMTP id af79cd13be357-79be6f1457dmr796242385a.56.1719340646353;
        Tue, 25 Jun 2024 11:37:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoWPotw+0VrcrvK+GuskbqBpoUwqThBFYkTLju4QKTs3hCDfwBWUdZAosjHkIX634yXoPh6w==
X-Received: by 2002:a05:620a:838b:b0:797:9c76:32a6 with SMTP id af79cd13be357-79be6f1457dmr796241185a.56.1719340646055;
        Tue, 25 Jun 2024 11:37:26 -0700 (PDT)
Received: from [192.168.1.152] ([70.22.187.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce8b3777sm427599985a.54.2024.06.25.11.37.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 11:37:25 -0700 (PDT)
Message-ID: <c08ab47c-944c-7393-d403-e4435cb283dc@redhat.com>
Date: Tue, 25 Jun 2024 14:37:24 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] dm cache metadata: remove unused struct 'thunk'
Content-Language: en-US
To: linux@treblig.org, agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com
Cc: dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240523210550.309116-1-linux@treblig.org>
From: Matthew Sakai <msakai@redhat.com>
In-Reply-To: <20240523210550.309116-1-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/23/24 17:05, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'thunk' has been unused since
> commit f177940a8091 ("dm cache metadata: switch to using the new
> cursor api for loading metadata").
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Reviewed-by: Matthew Sakai <msakai@redhat.com>

> ---
>   drivers/md/dm-cache-metadata.c | 9 ---------
>   1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/md/dm-cache-metadata.c b/drivers/md/dm-cache-metadata.c
> index 96751cd3d181..0ad9dc1824fa 100644
> --- a/drivers/md/dm-cache-metadata.c
> +++ b/drivers/md/dm-cache-metadata.c
> @@ -1282,15 +1282,6 @@ int dm_cache_insert_mapping(struct dm_cache_metadata *cmd,
>   	return r;
>   }
>   
> -struct thunk {
> -	load_mapping_fn fn;
> -	void *context;
> -
> -	struct dm_cache_metadata *cmd;
> -	bool respect_dirty_flags;
> -	bool hints_valid;
> -};
> -
>   static bool policy_unchanged(struct dm_cache_metadata *cmd,
>   			     struct dm_cache_policy *policy)
>   {


