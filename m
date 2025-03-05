Return-Path: <linux-kernel+bounces-546440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B146EA4FAB6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1D1164CDC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8FA2066E8;
	Wed,  5 Mar 2025 09:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cq8fU8CV"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6227B2063F1
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 09:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168396; cv=none; b=Rga9P9iwv0d70V2qbBg0mScqWYItCYV9MbiHbo09Nc45BDJEnLsR+5RxrRdhLsaPtF1fQzkbDbQztTTDc0YrQXY5QKbbKkASmrOGlhTbFxzBaba5u54UoZWJo6yJrIYT/woqPikFf5glck7HO1taBGbvAzKEuBeNTAptkaYXgmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168396; c=relaxed/simple;
	bh=HoQJfT/rFHWJRo/w02oVTwpBm6E1113uJMZPkO2so3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s2DrEWOLauxAIyIEiW0L8/WEkj5o9ctUffX6SjUcw7+m44MqysEgdM/+dKbMW6hlvDU4h3B6xONetNNg7SZgX5P9rk0y1AwTMU/H/jj2R78UBaOzVNPgcIfaJBWWKKSrSXC8N7HnaBcvVI5LTCPGRAQ+8IZpt4dECkTeo74VDaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cq8fU8CV; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6fd6f7f8df9so5764297b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 01:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741168393; x=1741773193; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QmssJ/v0i5j01lJBGvnparl8jLxew4PBDq3uO0lekbU=;
        b=cq8fU8CVMYuMMMXXkJlOARDlnfNUk0RmQdiIAzmg++S2PRA9gP7r/xQB+2nQrUT1X3
         AoilAz2ffVGmjvWrK93Y6nwM8cKdmSJRxeYtMZ080PMjxhkQZNKsPQ8OGEFY5j27J4JE
         oZ/R+xyXeWZugTVnZwvUnoeSXYOgD3KUKvW7XEQ+8vxh4OmFLXTSaiRuX64ClIZjKWzl
         dzvjQc1C/JJtLDtAlXWbz07rW+/+eXseinc1YGkkYkABARszSYWZjx5Dl3isy+WpSt36
         BiE/q6CDlkdWIHfCK+0N7RPmwyHjGLKAipJsAIk9Fmljhx+ZGVitBFYwWqu94WOvnGST
         wCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741168393; x=1741773193;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QmssJ/v0i5j01lJBGvnparl8jLxew4PBDq3uO0lekbU=;
        b=rGjBneCdjm4a/Fnd9WsxJUTYEDkccuTScHww0pzorobQ7MdskWttmRQmmqJ1FsTjBs
         lYmMyzI+Kld2A4nJqbTkivz3B4a+UWHFjNfcOu6tEulp4bhjFf+Ok5+RDl3GPLGijTTF
         pBi8cQkiL5tqIz0SztXSmsfAz6e2HE2HiyE5S+6x5nQVjjtr18NF/4uKhpsGeIUknkxy
         vfRbQhYklK1YgoyuqBLK3Rg0lPCDa14DSI8W8sk+EjbXUMQcxGSV/OssgD0WQYWy/wSj
         VTlnYyNSJqXDxEhTsN1Za1R3XlxlrCaW18J6YjXi+gXbPLhJXgu0HN2cJivdH3StQof0
         rMGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmcky/b9wfE0d0Hxx1DJgutSgZJ5NRmuJgNEdc8Ox8m9f1l/zezGYC4zFYSuylVOU53kgNqXznzbgLQEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzScvAx2fx65TH9eq0xcmf3SjLV/wl+noXHI4Q8u+U0gLPTp089
	oAGwsKUlNR8FF+zmL6tdZ9PK3cEE8+8Am9k3y/J7y3S3NoEzHR7VyY++70uSEBPR8Zaf1KmnyTg
	fDyoVdmky7NPokAzWbX6stjAAGiJq2olmrnzuJA==
X-Gm-Gg: ASbGncsMAJatWeLjfpiBmZJRRoMDLmsyINUXAXcLAG/MWHJGuPFqPxxtLYzBn7BTIBk
	762AyjzuAXaG4HVi7ancQUJ29gOdKjx2tmHAe6fPG41pKCCGW0oJsdgeqBCpN3RUd96JP5YyV99
	hpuK+KPC+py3rwPus5K3zcVe1Pi1dcpEITU/ilF1QdlM7TPHZhWMHh9Qu00Q==
X-Google-Smtp-Source: AGHT+IEGutT+zjkqQ3ATTBx4JIvA9Q3F7rEvdgRWipMrQxGQfkOkxCE0mT1COEBIClGaiCxKi9MsqIyKjbbm3vcPwwg=
X-Received: by 2002:a05:690c:6413:b0:6f9:c8d9:50f with SMTP id
 00721157ae682-6fd9411f614mr96778557b3.2.1741168393332; Wed, 05 Mar 2025
 01:53:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305203929.70283b9b@canb.auug.org.au>
In-Reply-To: <20250305203929.70283b9b@canb.auug.org.au>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Wed, 5 Mar 2025 10:53:01 +0100
X-Gm-Features: AQ5f1JpiBBDeRr2CNNwLxTLAV9GV1VBIlUX83g3DRCPQnKILf_mmS2GzkU3zVO4
Message-ID: <CACMJSetEf-GRjbHh0qwDB0c4C0iXCOBbjV3D4u30x8NbZdAD6A@mail.gmail.com>
Subject: Re: linux-next: build warnings after merge of the gpio-brgl tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij <linus.walleij@linaro.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Mar 2025 at 10:39, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the gpio-brgl tree, today's linux-next build (htmldocs)
> produced these warnings:
>
> include/linux/gpio/driver.h:551: warning: Incorrect use of kernel-doc format:          * of_node_instance_match:
> include/linux/gpio/driver.h:569: warning: Function parameter or struct member 'of_node_instance_match' not described in 'gpio_chip'
>
> Introduced by commit
>
>   bd3ce71078bd ("gpiolib: of: Handle threecell GPIO chips")
>
> --
> Cheers,
> Stephen Rothwell

Hi!

I just sent out a patch:
https://lore.kernel.org/linux-gpio/20250305094939.40011-1-brgl@bgdev.pl/

Bart

