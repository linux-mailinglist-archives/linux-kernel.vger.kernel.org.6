Return-Path: <linux-kernel+bounces-386063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA31F9B3EAD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 00:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD2CA1C21B41
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0601F8EE8;
	Mon, 28 Oct 2024 23:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XICKYJGs"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BD31DB349;
	Mon, 28 Oct 2024 23:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730159490; cv=none; b=D0TgESdCO5WzCmX/d6U66a6mHl37ciZp+rmHzhvTXbaMJgDuPz9ExmaGC/8lSgXl84snnsjYi0YGTdvcqLVHLiHPn7Ured/7qX8REpXg/49c9OqqZH/fkRV3FiR1p0rptfHuq5v7Kyk4VYX/SXaEJMRcnP9C0vozGbdwxRKDxBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730159490; c=relaxed/simple;
	bh=KF40bpPLCIp47l5yq3rfwlG48k9VwJV6SQEfdvsTTtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHYm2flfCiIQwUsDKw2NHZqf6OKJAMcDv2esovV/Jz1SfKtOUO2UEbKCyllnU0KTJL2wkWk8hxKR8kzmnEBmbgZGERymIGGjSMM28WbY5AIBqPPu/Gijnq+wrWkfrTa23vAfgZIxKlnTn4+Z43h8kQ4Ti4QYPzHs/Pnod1uHEa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XICKYJGs; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e2e2d09decso4148113a91.1;
        Mon, 28 Oct 2024 16:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730159487; x=1730764287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hBExjAcJs6Aul3nNaLRq3dN0oA7L1rfNiioxXb3aSZw=;
        b=XICKYJGshs1vc/OS7CmU9/0ickbLNWr1FzTMw4KlUyQzZ+Uvw6U9VwV+HkB5tI6dwg
         EWgG+MNpzozRK74ynAWIs7vBxYYpaaFld8vHApQCEJyKDMmAz4iCcutXc7b3HtLvphRi
         KGo1gadPs4UsHKKSUWjAwMWbtytuF58fB6RNy8C5vNAzWHOyw3+a0UifxN0/M+1pH7nX
         FxAtG7dIQb7jJwyXv7qanFE7zccgNREU59x/DhxgUX9LUaidarTItaDzvgi8GLWassA9
         r02wFhVJ9SC014dNGW7UldMWGhZkSeEQayAv5dGm70kuwBNJvTjdZElsC89r+R1dFLuZ
         NVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730159487; x=1730764287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBExjAcJs6Aul3nNaLRq3dN0oA7L1rfNiioxXb3aSZw=;
        b=HxneUADZAwN8v6xAS300VLHVVei/GsJWlO5nOgQC55K9gtLlOrjk5PFg7IXUJ4oagR
         HbAlV7CEi9h/hX9m7zxu50vPa1PgA/hZ9i5hoaoAzX6Laa51KfFW2LM5vMWq8P4wXoAA
         3Ip5VwtOe2ZjCbJz4u2Px1Ti4wHHdilmg1ja/DTHi7iVbwbB4aCOw+y2GV4zBBmHMjUu
         G4AmC860UoxPBLBkOfBplpLwu4ZlYShvLltUvmsu4W28ILgaOciYRdT78pVtbbA4kAsc
         0ZT4NGXxJie4zAHBfiIC8/ym+G1gRn6A4Jv4g9N30FUI9RG0o3XIcMpuyhgfFHcjX4WV
         BvGw==
X-Forwarded-Encrypted: i=1; AJvYcCXQOVd8fGhKBOpFNPt5fXY5nb9Zmdpzu+tYqT8Vzew6hVcX2HvnJQjLPXVfQlcMPCF9687WgNX1PJFT@vger.kernel.org, AJvYcCXx9s+3o2eje37odRp6jO6nuN47CIP8tNtKhynCU4Gjn5ax5B+EeyKN/uGWhFOZl/WjSdAvRlE6oa1atwq6@vger.kernel.org
X-Gm-Message-State: AOJu0YzU8BKu5h4bEwK3q1QpWt4lCa2y8xIFC0BJlWtbxZACVi0pF4qd
	R+qPIZcLbs7VtgAHf1lJTwMujey0QQ392Nk7dWt8Ln+skme1THdy
X-Google-Smtp-Source: AGHT+IEAlu5S8i7peqRrFUMZF8zh2gi3qfjhQkwwkSfMMnI1yIFUJ1hhJtZf/SeEqCbo08WGvwjGRw==
X-Received: by 2002:a17:90a:3044:b0:2e2:c1d0:68dc with SMTP id 98e67ed59e1d1-2e9220baf2fmr390549a91.9.1730159486593;
        Mon, 28 Oct 2024 16:51:26 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e3771814sm7955697a91.52.2024.10.28.16.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 16:51:26 -0700 (PDT)
Date: Tue, 29 Oct 2024 07:50:45 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	=?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Inochi Amaoto <inochiama@gmail.com>
Subject: Re: [PATCH] riscv: dts: sophgo: fix pinctrl base-address
Message-ID: <dvu67iiddw2hdtfl5ezjxi76idt7pcj6kaapraj6kv4hujh65j@zqhaaiuridrd>
References: <20241028-fix-address-v1-1-dcbe21e59ccf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028-fix-address-v1-1-dcbe21e59ccf@bootlin.com>

On Mon, Oct 28, 2024 at 11:43:24AM +0100, Thomas Bonnefille wrote:
> Fix the base-address of the pinctrl controller to match its register
> address.
> 
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> ---
>  arch/riscv/boot/dts/sophgo/sg2002.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/boot/dts/sophgo/sg2002.dtsi b/arch/riscv/boot/dts/sophgo/sg2002.dtsi
> index 242fde84443f0d6a2c8476666dfa3d72727071b1..6616f578d190f7aa2a82b233fa9c55267b41ee0e 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2002.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/sg2002.dtsi
> @@ -16,7 +16,7 @@ memory@80000000 {
>  	};
>  
>  	soc {
> -		pinctrl: pinctrl@3008000 {
> +		pinctrl: pinctrl@3001000 {
>  			compatible = "sophgo,sg2002-pinctrl";
>  			reg = <0x03001000 0x1000>,
>  			      <0x05027000 0x1000>;
> 
> ---
> base-commit: 45a544a62ef7cac9ecc69585a90da72ca68af898
> change-id: 20241028-fix-address-e7f0c40eac2c
> 
> Best regards,
> -- 
> Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> 

Reviewed-by: Inochi Amaoto <inochiama@gmail.com>

