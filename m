Return-Path: <linux-kernel+bounces-564898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A56A65C76
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F778421318
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713C81D61A4;
	Mon, 17 Mar 2025 18:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejQjvgRB"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7779A1A7AF7;
	Mon, 17 Mar 2025 18:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235807; cv=none; b=HvstSqH9IUXpLPegTVl82LVLYVio+d9XF2EdTCvKNuUfWQtCEaPWRCdPW1dStAzUKlZLo9uVZC/+6DXrQIz8nXm922bh1p9kEci/mZjckM9/iC9O7nyRDobIAah+yncZA1iUknl+CJXqfG2UpgBaucCPdhvjj0KszBuDSiE7NU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235807; c=relaxed/simple;
	bh=WS/beQDNL7wmrZ0qggdva3xoNx/Nfmh6FfFb4BzMBMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYCahcPRQgwO01F7pZyUtjVK7QilXoCf4Y2cJ7lOlPV9/KfR0htaOO8x+eUXI7N2U4O6VqcVDpVc9vB3feF5gJa1YO7vYFpPx9OAiH0x46ydZwvl5QKp1wquWir6RiNLP+KRoYOY3GWA9aIAYQJFw91d4+GrGxNjhTK+Sne/Tdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejQjvgRB; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-225df540edcso61226285ad.0;
        Mon, 17 Mar 2025 11:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742235805; x=1742840605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=raU6yvjFajPdul3fWiqTUWQ66/KuoIXSGZczRw+B49M=;
        b=ejQjvgRBgFpxGo+Luq2GpdBCHJP7J4vykm0B6SvQOabAeGVoKw9HGvUaE3HbQ4DldU
         XbOhg9V3wooyC5RbeQKza956AcaD/AxRqTucHkenmslnXfoSbPDDjYM4NMdw1EEYnDII
         cAYREBz06GmQm8QSIKZ7KwHVi0jKHoWFOYXW4rNKD7yh1ZIrs33XUaoR/vXb7lNEkHoK
         QdnF6c7i+IJGvTFgUf0WW79MBNFXumEDwVUBrspmRiFKdjkEcmRUR1g4Xs3dNpFG55SP
         0Z/zY06Y0tMJusExGe/j7MVdmebf3YSba4iF2UP5+c30URiQpfB2j4RXozKG/zFuWaM1
         2cKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742235805; x=1742840605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=raU6yvjFajPdul3fWiqTUWQ66/KuoIXSGZczRw+B49M=;
        b=XYVq4ccEik//eogbhHhnFkeCoxgAjqPfyxnmfBBZDD1FGJuh/G0toLgfFn3PpkQ5cU
         Wi9rf1lHZYZ3q6rDeGW8zHTvMajGcrWN8HMFU8di2shuVl/TXfZr3VIhvQXFZfQeV2Jx
         N4yaqxnaXckpF+BNOpoQ4AoGTY5Id0UWP3FCnIcGYKBrrwp9KW+Q1KDAyvz/fgJtkt2x
         iNClu1FrQxnIcBueusLvdP/oAEeeAI1WfEDYHspRxMilHsXL0hhtja9IX/iVFc3eMoZf
         PzvCE1hgpaXEXATlmTaTfNh1al3iT+xsv4Nng4ngFBnxTSW3fJyqIefQUxJG36MO5eb9
         i0WQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9G52i2EfNvIJwtNliE+QwgckO8UzdvYDftnLRne4lMmaNtH0mS1LuPzWEYpR05ByYXag3Q7L8CKu66jI=@vger.kernel.org, AJvYcCWNr9Dvy2zI2gNSJPDbNd/TBYiDHu26xTKaF0s038pU9D5j79pGgl8kS6gnwdPiUY+Vhsb/VEuFdrS3@vger.kernel.org, AJvYcCWlPQehVeOm2N3/8pMiwkscCily9/bbJToRguvaIPZOVQkFJ5B/Pb+yr7GeOD8Mv0l8XqdQN/6c9ImMAENe@vger.kernel.org
X-Gm-Message-State: AOJu0YxIbuB/f6XRrxYxi/NIiVzDNhZK9n5YCxehWHOkVC607o9+Taoi
	Z+EFJefchN5ZK4PHFxtJS34dxXeGz5WJOmPt/g4ywnzoJMl3iXDEi887AQ==
X-Gm-Gg: ASbGncsRJ0RgIhtOXF8DBfM/hUy7xrWeU5TPvvX8EhFacul6ZDFUL1oX2Gbn7SXEV5d
	9c55c6RLxAmUbJOAOAlCc+jcfh6fyQ2pApvsknVQC03XO/5CXrapk96PC/p64qXZ8g9tm9/m5N4
	Wk7qRK3Np43SFMub+g3M4hOqGaTVE7sMFga5rbGUOFv5JGyUS1na87l0vEhULj+InFuBdzLR1Tp
	9FiuUQxHJ6jnILNuXkwDj+BCm1WrQci55tw1vY2IfOVzGnCuKRU99EFCSzAJbn/CmTpLYlD+NyJ
	CFQxS9DEPfaWeJUlT2fe0/AM+SqQOAwOt71EpXVdEaFkRo8nhXP7VtVszQ==
X-Google-Smtp-Source: AGHT+IHoApapmryAS+pdqlIWcy577+zynlAjn596ZSexCbyRdAhICkcLH0GhI0QnYoYouuGmfnIP7g==
X-Received: by 2002:a05:6a21:99a1:b0:1ee:c7c8:cae with SMTP id adf61e73a8af0-1fa4ff2e285mr540102637.9.1742235805638;
        Mon, 17 Mar 2025 11:23:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73730ca057csm4665831b3a.48.2025.03.17.11.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:23:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 17 Mar 2025 11:23:24 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Andrei Lalaev <andrey.lalaev@gmail.com>
Cc: krzk@kernel.org, robh@kernel.org, christophe.jaillet@wanadoo.fr,
	jdelvare@suse.com, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH RESEND v3 1/2] hwmon: add driver for HTU31
Message-ID: <a6c54c30-bafa-49fd-99c2-e5e31013bcc1@roeck-us.net>
References: <20250217051110.46827-1-andrey.lalaev@gmail.com>
 <20250217051110.46827-2-andrey.lalaev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217051110.46827-2-andrey.lalaev@gmail.com>

On Mon, Feb 17, 2025 at 06:10:55AM +0100, Andrei Lalaev wrote:
> Add base support for HTU31 temperature and humidity sensor.
> 
> Besides temperature and humidity values, the driver also exports a 24-bit
> heater control to sysfs and serial number to debugfs.
> 
> Signed-off-by: Andrei Lalaev <andrey.lalaev@gmail.com>

Applied, after fixing:

CHECK: Alignment should match open parenthesis
#493: FILE: drivers/hwmon/htu31.c:254:
+	seq_printf(seq_file, "%X%X%X\n", data->serial_number[0],
+					 data->serial_number[1],

Guenter

