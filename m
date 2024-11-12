Return-Path: <linux-kernel+bounces-405134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D949C4D53
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 04:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87CC81F21636
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 03:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C262D1DFE4;
	Tue, 12 Nov 2024 03:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjhjPaS3"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD4641C79;
	Tue, 12 Nov 2024 03:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731382198; cv=none; b=XpbeXEvitQ7OMVklowdDhlcBWsqA/RElbH52giKiUEWzGO3GEsxE9b8DtYfaq0qEq82UmGvfYkcBoofopvzj2KDuycK2ZjsMeI+YNMhbYqljg8IvpEiV/NeAu8KJUG622ISAzgYb84UTUFGJrUr8/i3lA4Kaqgv/jRTnPzxtmA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731382198; c=relaxed/simple;
	bh=6UpsJSWh4Oa+OP2fFrBg1S/DUIRXHnoS8t0cgV8rsjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVaYMMOw7NLBmuf3lV9Kd+xsjTmdfRTMyR6+UdxupqkiSU+rYsH6e2UTDCmq2op4cKi9ZhCXY82h7k/4qKAcO5zn9MZBvHVf7oymMCUSS/MT1/sTrRcfYdwnMF/WeyOk4IxwoUQEVovbO/J20IJUWiutYss8OVYU/XKLkxFW8Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjhjPaS3; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7f450f7f11dso1393641a12.2;
        Mon, 11 Nov 2024 19:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731382196; x=1731986996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WQiBHYPub6Sg3L2ZwXeizlo4TlXYG1XXGaB98Hlmo+8=;
        b=PjhjPaS3+Sh+gjoXeSw9LYRPOq9PAFN9Jo8uSyUdnnOnYrTrqgIIwZMh7pwB+7+nCn
         wiRq2jUwPyssu2vaEiFlFWv2+SiXy5aR1zjOZN6Wj0oCEv1+xlNVWk6EAnAdHe421SeM
         3iEx71Is7i/VvCk8B7USEMKyNKjvJavOG8D/sSD+YfLpj+btmkExIEfYfWzL5guYP63g
         pOq+9xOT4sRpQjztuSUyupG7FVVnB5387Mj/XE7faE6n8WmzUFBL7QoRYfuswW1X0m9y
         qXvp/ivbr9cWnCNsNalRa/KfhH5AZuAst7UEdWq51xlwLgrBJD1dLT+JFMeWlRnbe/M9
         xLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731382196; x=1731986996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WQiBHYPub6Sg3L2ZwXeizlo4TlXYG1XXGaB98Hlmo+8=;
        b=N91EcXYF7fImE5UrMbXKAJPOV2ZIY1w5Gm8nqDzZZWhrrhm6dna3uNOOYFgtQ7yk2M
         rEWMJoWsPBiA/NuX1S09VtPiFpZo4FCa7lQkdd3JTyE/xfOsWqNASN4igNfyKm6mDVT8
         KbUrsl00/izCV9LdZLb7aDSZyOZwFLSuEQsUTE8NUSvYmrDzZOhTOLZw6bxZE0f9fiyQ
         VGOPke9CS3GZEtWA8lKbdWyEf+vtA41rE7FXr9WyOQVVvKByX/8NRBkVFNvKBYDF67iz
         Sl/XFrbJAvbtpi0CNAr0RBV+YFGlc2fnEkEiRWWnfSSdVxCCJCQBA6yEYsznRzbMIAqx
         8jaA==
X-Forwarded-Encrypted: i=1; AJvYcCXBGaSEo4MEFBsAFyPWuZSso2bthOodI1xA2wEkOID4fVmc+p09hlhml3AyzjDTk3n8XeEomkUbybNZWYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxjEj0+qSy5xQdo71IL5nOpYGtLw33K6nZk4stQo6s9gLXN1FS
	N3Fq3iHNJWd5if7mZdN8sb3cqYPvN3tx/OUczb6mPbx51GEmZPdK
X-Google-Smtp-Source: AGHT+IHDXSszEJD03BfzgPGcxE5WwSbJuMNqQ02jfPw1X4peHEBxadHEU1nXOuxbZfEOLBr8vMmykg==
X-Received: by 2002:a17:90b:5250:b0:2e2:e769:dffe with SMTP id 98e67ed59e1d1-2e9b1773bf8mr20709987a91.30.1731382195873;
        Mon, 11 Nov 2024 19:29:55 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e59c45sm83858255ad.197.2024.11.11.19.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 19:29:55 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 11 Nov 2024 19:29:53 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Huisong Li <lihuisong@huawei.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	jdelvare@suse.com, liuyonglong@huawei.com, zhanjie9@hisilicon.com
Subject: Re: [PATCH] hwmon: (acpi_power_meter) Fix fail to load module on
 platform without _PMD method
Message-ID: <1369a551-3464-4874-863f-df453c6e5c55@roeck-us.net>
References: <20241112021228.22914-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112021228.22914-1-lihuisong@huawei.com>

On Tue, Nov 12, 2024 at 10:12:28AM +0800, Huisong Li wrote:
> As ACPI spec said, _PMD method is optional. The acpi_power_meter
> shouldn't fail to load when the platform hasn't _PMD method.
> 
> Signed-off-by: Huisong Li <lihuisong@huawei.com>

Applied.

Thanks,
Guenter

