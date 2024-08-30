Return-Path: <linux-kernel+bounces-308882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6465A966309
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 575A51C2300B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FB71ACE07;
	Fri, 30 Aug 2024 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQwCRW+X"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49F41D1305
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 13:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725025118; cv=none; b=dDMWkOtaEapvf15k+FWCYR7LZWmkNUkX/4oWsSG0Yy5sud6NL/oPUh0tDJ1kBOb4qoE1Rw24hT8CU8qijAb4aKOAlM1t889XDqUvlFYas4Deblt6gD3EylHESj7Zq9vYI6r9Eb3rV0UQfa54KkRWrdFo7osp1J6Hx4LIbx/PFXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725025118; c=relaxed/simple;
	bh=u6yEMg+Sy3WrlsSKOmhRZGlPPmnWIYXaB1H+A0j5qUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mQhE6mJhiptYZRQxFWBmXTEiHh/SXVQYERVCUs6HjmByyNGXlNnVZl9N/h9tr48zzjZWPV5XfTIGmMCVXlrR+q9HdLq443nJzykBtFjWKjLbaOSORgW0Nc/XiQyk/KAUXyj8oyJmF5SwiCzFPVLwOk3dHko6U9s+sViGjzyPYhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LQwCRW+X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725025115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/lnYJxpN69J8qATFGtH1eTFCR7cxesgL+ucodMgPbP8=;
	b=LQwCRW+XZmbu8JeIa955jk70G6Pl2aoP3fU7GbDfdmaak2ORyKqL2zseUlDHEC22kvjnTY
	0iW+hm7b1EyJQ1z7fFbcJdgxbsismGkKcoU+GNu1fWVy3FnJRMyR0Dli/uUc/7fIdk27xd
	6FsEXT36t+tPHLjebieIVyvodb65T5s=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-Y8J_fEj9Nki7eeLq1zEr_w-1; Fri, 30 Aug 2024 09:38:34 -0400
X-MC-Unique: Y8J_fEj9Nki7eeLq1zEr_w-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d505a087aso14988735ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 06:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725025113; x=1725629913;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/lnYJxpN69J8qATFGtH1eTFCR7cxesgL+ucodMgPbP8=;
        b=do6SyKaHO+s6ixBXSqHTVE2zS4TIMCMU+R+HPSGg3QU1fsn30IOZu/KoSPFvQYTuQk
         oMSiZhMPhV5x2xShixooVPKgmjPhFV1mrAv/fxI2T5X0+wxQnIh60oMGhW4eCybY3hpX
         OHrFeLbDF2ow5v7GkUQ+fME/AEjFDmKSYgnfLgXXjcv0Fz2pvW/+6le4M1xnGOh5liiM
         hG9hVPNwj3xeSIT54/7cFxh6wl1qnZcKxJQKrqYOUKEVOBfbaQR8T2W8bHP3HAeHW113
         KRBaFO4pt8BwULvoYpYBr9D46gBVvg6D09EkJTaUTTjO1qwl3bP1fopHctgxyov4npv6
         nMYA==
X-Forwarded-Encrypted: i=1; AJvYcCUOIgg23Ka6V0Ch0qH81smLv+eSfQ5IFk+Vw8JvcOJYS70c8pMkskhGRq5Y0YZ7wcYzkA4C5TWkPwj6mBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzScOfwbKsedFRmyLSqLbH/mjPM3HMeoU7Mr6+o6zQwF+/MRx44
	s8Irfdm90CO50WFquOoiipQjlwx4MUBzZT9fsdWrhddJJkRCwh4RcJ0skzf5USl0TPodHjB1RN5
	HWU2DhjH5XNr2x4feliMP/M7VKxzAqqDZCUqdPVeyCUUx68xQFwRtil5sn0Xj1g==
X-Received: by 2002:a05:6e02:1a64:b0:39b:36d6:2150 with SMTP id e9e14a558f8ab-39f413a733fmr15594165ab.6.1725025113381;
        Fri, 30 Aug 2024 06:38:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFygJyeSSXGjnVTl9d3W0zSnLorXQTfDvo5nu0lQ+GD51miUw6vNSI+MhTrbx4DlMXhi5XSPw==
X-Received: by 2002:a05:6e02:1a64:b0:39b:36d6:2150 with SMTP id e9e14a558f8ab-39f413a733fmr15594025ab.6.1725025112963;
        Fri, 30 Aug 2024 06:38:32 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f3af973ffsm8554185ab.18.2024.08.30.06.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 06:38:32 -0700 (PDT)
Message-ID: <ad3a24af-5366-4c20-ad46-6f21d6754bbe@redhat.com>
Date: Fri, 30 Aug 2024 08:38:31 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] debugfs show actual source in /proc/mounts
To: =?UTF-8?Q?Marc_Aur=C3=A8le_La_France?= <tsi@tuyoix.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>,
 linux-kernel@vger.kernel.org
References: <e439fae2-01da-234b-75b9-2a7951671e27@tuyoix.net>
 <2024081303-bakery-rewash-4c1a@gregkh>
 <0798a2cf-b43b-4c17-94a0-142314d80f5b@redhat.com>
 <alpine.WNT.2.20.2408181925400.3116@CLUIJ>
 <883a7548-9e67-ccf6-23b7-c4e37934f840@tuyoix.net>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <883a7548-9e67-ccf6-23b7-c4e37934f840@tuyoix.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/29/24 10:44 PM, Marc Aurèle La France wrote:
> After commit 0c07c273a5fe ("debugfs: continue to ignore unknown mount
> options"), debugfs displays "none" in /proc/mounts instead of the actual
> source.  Fix this by recognising its "source" mount option.
> 
> Signed-off-by: Marc Aurèle La France <tsi@tuyoix.net>
> Fixes: 0c07c273a5fe ("debugfs: continue to ignore unknown mount options")
> Cc: stable@vger.kernel.org # 6.10.x: 9f111059e725: fs_parse: add uid & gid option option parsing helpers
> Cc: stable@vger.kernel.org # 6.10.x: 49abee5991e1: debugfs: Convert to new uid/gid option parsing helpers
> 
> diff -NRapruz -X /etc/diff.excludes linux-6.11.0-rc2/fs/debugfs/inode.c devel-6.11.0-rc2/fs/debugfs/inode.c
> --- linux-6.11.0-rc5/fs/debugfs/inode.c
> +++ devel-6.11.0-rc5/fs/debugfs/inode.c
> @@ -89,12 +89,14 @@ enum {
>  	Opt_uid,
>  	Opt_gid,
>  	Opt_mode,
> +	Opt_source,
>  };
> 
>  static const struct fs_parameter_spec debugfs_param_specs[] = {
>  	fsparam_gid	("gid",		Opt_gid),
>  	fsparam_u32oct	("mode",	Opt_mode),
>  	fsparam_uid	("uid",		Opt_uid),
> +	fsparam_string	("source",	Opt_source),
>  	{}
>  };
> 
> @@ -126,6 +128,12 @@ static int debugfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  	case Opt_mode:
>  		opts->mode = result.uint_32 & S_IALLUGO;
>  		break;

Sorry for missing your earlier question, I was thinking that perhaps a
comment along the lines of this would be helpful:

	/*
	 * Because debugfs accepts all mount options and indicates
	 * success even for unknown options, we must process "source"
	 * ourselves here; the vfs won't do it for us.
	 */
> +	case Opt_source:
> +		if (fc->source)
> +			return invalfc(fc, "Multiple sources specified");
> +		fc->source = param->string;
> +		param->string = NULL;
> +		break;

but I suppose it's not a big deal unless others think it is.

Reviewed-by: Eric Sandeen <sandeen@redhat.com>

>  	/*
>  	 * We might like to report bad mount options here;
>  	 * but traditionally debugfs has ignored all mount options
> 


