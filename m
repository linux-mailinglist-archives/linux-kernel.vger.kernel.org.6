Return-Path: <linux-kernel+bounces-345768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1C398BADA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB3001C21F4E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795EB1BF7F7;
	Tue,  1 Oct 2024 11:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9WRznLm"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8334439B;
	Tue,  1 Oct 2024 11:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727781561; cv=none; b=ODYlDOuqboQMUIpg8nfq4f9kI8xibdps5iaZ94PMiSvql+Cbw6AZ7/+7p2fB6bDKm7MvDDMAdjGsX3UzEub0P1QB/iFQOTsiVXU+zDLbv9Z6b0iG2UJOR0tUKAAgkUmrdOWlCDgqm65EDDRPEKdbKgyOU1UuRvnpuRpUGo5MF90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727781561; c=relaxed/simple;
	bh=7gz+42kgK/bnSKCIOOtjqUw3T5MP6gnuAfi82O4lUYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxl4TftD8onAKyGkirXEDgEAz2yDpgwqkEAtpHJZtrVwESGoHhlhcKb05NoLwdm9uNgXojQVS8txTB0CUyQHwz7nRCSvgToOzPVMb7VwvP8YliI2WEKlT8xwNHipnuIFSKnKVcwUN6MI4fRfK9RovHqqDhkeeFqvtVFx5OvmqY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9WRznLm; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4583209a17dso55121821cf.1;
        Tue, 01 Oct 2024 04:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727781559; x=1728386359; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YzE8KTQJ74z16EqMO6/Jz5kTP2C8yUTaMCEw4TZ9Ym4=;
        b=f9WRznLmS0xZrXlgR6gYZx95EufpR8zfuLf5H1ZxVqtPaIhFABH3V29LNebYpCzgh8
         CaExBbUCCLVNwguxL210X4TSmFLGd/729Q+mlIsvNxFrOY+C3UiE8QoPdJnsPzBsrTAS
         d1G/pNY+AEDK0F6dSsWJ62UpMXZtSnEjYX4r24TRZz1ydbUMXI1bsFNYrZN0G97Qko7z
         34IDT3IPenUYs/2+6AV4UmObOm6hioV2aox6WmhRDLbM9OJmjFB0xOsMFI4ydbmEyJlD
         Ra3Rmp5+qvJtzpUyQbFVQwJCwklp8yQQtwR4E9HWVifjIPGYMKxkdAYsk13O4IBqGA68
         i+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727781559; x=1728386359;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YzE8KTQJ74z16EqMO6/Jz5kTP2C8yUTaMCEw4TZ9Ym4=;
        b=G/Eh41EVhTD2GxTVyz+DTrmxlhzfan4EVPlAuNsE2FcJTrRA7FRLR3vg77kUUFp9QH
         eXd4FIqFbJWJmOSWn6ZIUbFp1mx8wl6MtHA8c6vnkedtiJHVQIxHJmW/sAvmytW0TrDN
         r6TWyYFh+4eAocKwS8dA218U73k4JEvJ9C8YnXNaGqeZ+ONADR15Ogvry6fOow/Ge9mg
         PP0Fojd9kVJqAYcG9yF8btIIIbY1Lhhq/2fMPr2CDE0mDtDHEQmWP9qk/BEAWl3tSAIA
         9vrCvZomp+KdGd7YBpSCGT1b66KQRaRPCDZrKlBo9Uy/8xp/7qKAwwbcFtiNSbmN7oE9
         nkeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe+gQmATi9lxfiiiMoqZoeA1jnJxoS6zl8447cOJPa3MSycsu3U3tcLPE6ytMquleoIoZxim184jPQBUI=@vger.kernel.org, AJvYcCXCi8k/xPUWU93ZbeZv1j1i1tfcxvb/XuXWoFUraY5/TkjMub+FJqbiDChaCp/75h6fUHTrDIyLsMxImtr6+GM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFrzWJMS6w5RzfpMhlR+abi0DBlr++Lr591zA17I5kfAXVqAxn
	6WWz5yYRpXdTChTETr4//g0Ydjxj+1KtSV4OiDYz1VOsVB6/i1TA1HHqfHxszSUSCb57SmRCJoN
	EkcQHm0X/jSYBrY4fJy8dfnjqvkI=
X-Google-Smtp-Source: AGHT+IEDEcWLSGEOeEFdKeDbTaWfrnPZ4NIZgYCXUkJcA76aaiSnLmOWoKuJpkiW3T2aTnRBgP9GwGRm4n9Y/OqOrBs=
X-Received: by 2002:a05:622a:341:b0:458:38cf:410e with SMTP id
 d75a77b69052e-45c9f20ab1dmr268190521cf.22.1727781559364; Tue, 01 Oct 2024
 04:19:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930194637.98260-1-trintaeoitogc@gmail.com> <2024100107-stipend-lid-1beb@gregkh>
In-Reply-To: <2024100107-stipend-lid-1beb@gregkh>
From: =?UTF-8?Q?Guilherme_Gi=C3=A1como_Sim=C3=B5es?= <trintaeoitogc@gmail.com>
Date: Tue, 1 Oct 2024 08:18:43 -0300
Message-ID: <CAM_RzfYvBS_kNqw0d7z1CRf5XL2LWc0bNm3YCg2asPffi4fMZQ@mail.gmail.com>
Subject: Re: [PATCH] rust: device: change the from_raw() function
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, aliceryhl@google.com, mcgrof@kernel.org, 
	russ.weight@linux.dev, dakr@redhat.com, a.hindborg@kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Greg KH <gregkh@linuxfoundation.org> writes:
>
> Hi,
>
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
>
> You are receiving this message because of the following common error(s)
> as indicated below:
>
> - This looks like a new version of a previously submitted patch, but you
>   did not list below the --- line any changes from the previous version.
>   Please read the section entitled "The canonical patch format" in the
>   kernel file, Documentation/process/submitting-patches.rst for what
>   needs to be done here to properly describe this.
>
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
>
> thanks,
>
> greg k-h's patch email bot

How I created a new patch, and not another version of previous patch, I really
don't incremental changes after --- line

