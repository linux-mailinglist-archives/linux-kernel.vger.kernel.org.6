Return-Path: <linux-kernel+bounces-242927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B78928EE4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 23:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94B381F212DE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 21:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A3E16C87B;
	Fri,  5 Jul 2024 21:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgGoxBpf"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6931459FE;
	Fri,  5 Jul 2024 21:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720215437; cv=none; b=eufPjTfJxabrdRFq0Ks6pSErL1dOfHmpqE95w3II6Dj0Me1B8jG0pukrx9XsAF+nFcpFWJhr72+w96s2jynSA4cPnW1LOzf7k5cNIhaPQiYuo2EOuxTrIM0Bijz8R0UFzDdXOPtPXU/jUAqRZpvZODA8AoL1m+qRtgvUCsi0oIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720215437; c=relaxed/simple;
	bh=lF5/GOendtxAGWdTRA4zO97H9E2IxnNbY3pQFWo+ZpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbSB3jiugXZ5jB1lA7i8LAxD/DFb8oaPb9yAqkhnDTpKfzqzL6cjrNza31MLebfxSnhdC8CP5HgnfKR1e2Rl6vxUSfllo5ulSwmxJdmNtQk5viWx69VKemUJ1DStmdv7bIpUr7it3YHQ3j7g9jGB50eNKzBxCnlfpFRJL9RRP7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgGoxBpf; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fb3037b47dso15549145ad.2;
        Fri, 05 Jul 2024 14:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720215436; x=1720820236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=248HNA+T8LaaYCfrgX5PmDbywhpni6O5yNgDVaYtQgM=;
        b=YgGoxBpfZVJ3TD/5eHveYBNaDjE88r54U2wmRbC5x+toa8uczpMKfpILN7oPCplp2V
         lr/Kfc/gEp2eOTSnsPt8DPsi1bqmQ30kZZ4hftHQUNzLzBuKA8iOXEsmT4JP/mes/ofD
         gTFVdThUkjR/ycrQ5b4DdLWz+HVSkicVr/Z5DuDuTaTuGmLe85Hj6R8wCqojIQHbldow
         Jd42FhWgDvQHr9kihtKmie5Jlvh4SbiD4Fbz3cW/whg9btjZymXck34KyZJVLOeRtfJ5
         pPhnGFa/WTvjNfAnez1OvZd9VBoHKwehBDnxLbP/W/sx6GiqeSp9zSEpHG7voami562X
         MbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720215436; x=1720820236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=248HNA+T8LaaYCfrgX5PmDbywhpni6O5yNgDVaYtQgM=;
        b=KNbhEDFHVqA6mGKCvs+xci2ihAgzxdclpPgs9YfNIZkWesIDmHKzVtQ6YEq5d+BZp6
         GakeGBRLUkJS6lAp6sWTdk2yFhLsw9OWNwCbkB90NpUicp50m3cmB6it3gZHYlLmnHm0
         iuMo3A9u4ifzoeiZYCVbq8ZTafYK1Pbet3zR5VTHFXIs2MAjG+Tufi26R1JHdXPwBUvt
         T7oHu0KVQUjVrPJU+Bw3+scep+C+EQAaWs0sFDRTrigfy3bL7ABOZQupUGBcMNli8fno
         /lWT8tzqxn+W/CfgClbzme+oyM0gdYsUxxzNg10Kc5NXeC21VMq6fcMON52d/RL8PHP1
         Gjbw==
X-Forwarded-Encrypted: i=1; AJvYcCXSWwsMHw4vfL1DwtX0MYPtBSzgm/ZDB/jWjscuMyVSAzRvviGgHKJfeFjIbU/mBoCcYLlQiCJo9KF+XthxDZvnYiQozzed785wzny7rUphuUmxcrQNaJG/T/xSurgLnKQRgJ1ECZ1pRoo=
X-Gm-Message-State: AOJu0YyrIKLWJQYqaR36z6qX6NOt/zHNQUBBx8u9C9/NW4ODJrwj/UCY
	zFO8TvF/O8CANSRbgaAWNoKPeRkSd6KlGO/kElVIQZ7V0s8PhC8LkPOPsQ==
X-Google-Smtp-Source: AGHT+IFsmeIr1zPdMMsxyeLKzF+lWvjNhE87tFwxCLq5YowImhjGvnQFM/9k61Dp7aoaKYhuTWOGmg==
X-Received: by 2002:a17:90a:bd87:b0:2c9:76e7:a408 with SMTP id 98e67ed59e1d1-2c99c6b0230mr4050540a91.19.1720215435725;
        Fri, 05 Jul 2024 14:37:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a95197asm3859986a91.16.2024.07.05.14.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 14:37:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 5 Jul 2024 14:37:14 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Tim Harvey <tharvey@gateworks.com>, Jean Delvare <jdelvare@suse.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (gsc-hwmon) constify read-only struct regmap_bus
Message-ID: <b26eb272-6d04-4165-a15e-44ccc6049b72@roeck-us.net>
References: <20240705-hwmon-const-regmap-v1-1-7cde543ba818@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705-hwmon-const-regmap-v1-1-7cde543ba818@gmail.com>

On Fri, Jul 05, 2024 at 08:27:28PM +0200, Javier Carrasco wrote:
> `gsc_hwmon_regmap_bus` is not modified and can be declared as const to
> move its data to a read-only section.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Applied.

Thanks,
Guenter

