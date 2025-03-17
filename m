Return-Path: <linux-kernel+bounces-563651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BD2A64611
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6331B3AD8AE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700CA21C175;
	Mon, 17 Mar 2025 08:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGJoTndx"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525F085270
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 08:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742201280; cv=none; b=k+xT3XkXkqir/VHUbbeBVhul1PJxjYg4adyBK6hiKjvA8z2xmXW5Uvu/eU39JiB4fqvRZN68GaGJo94Hyym9I2fGa0BaY48ysCdcC0Egt/QRVjDf4T8EnQXoq5XyaueOJysU/RkxXmcnAdIOYOMsNKhri0b+gIOFsuuVnKND+G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742201280; c=relaxed/simple;
	bh=JWF40QUvcWkqOKGgqM72bACfGKf0BSEtJRD7IGnHZXE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cAb4Jy2wmk50cRwYnYArYB7f4IoYWRCVjLaRb8Yx1mJL46jlaeUv7xFYs8KAL1IHu0Nj0bkfqOaERH/3VDt6h4tFSxXSdeZzPVQ5Aq6EFjXanzxycVmYqql0EB7vE6zIvmu4fZDli/9X1VxtJdTb9OjGtgWyEI77OgqSo6ohrSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGJoTndx; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac298c8fa50so775705466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 01:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742201277; x=1742806077; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sivy2dFPDfrrWNy8pgqRVOZc7Oa4LQfVg4rx4RY+3RE=;
        b=ZGJoTndxbK7wgS7feISnYDbJYEG5PicMMFrOGnk4bQwC65KZjy3kERwKdfcoiSZs61
         jsK6VYrhbcyuITWeL7eis7uwZRQHcJVPsbjyEjWG8nXL+Hzk5tgkuqna/CzV4ecrW+Ir
         Vwg/BnSZInI4CxvNyH2dzm0u8J3sneGWTu0jhr9algwOGj9MUSqIDLfmVIUiBJ5k2pg2
         WrM/A0n/iW8pjf9D6h98nNK/k8ugmCZzzrWo5qjrcyUn/Z9qN8ikuj1vZAi/UO3RNrnj
         jAW9dFWgxXlefbb25qQKQTUxeogD9QzeQ7EFAlKbfyJElfypGD0xLZ8isVb/SdIYj+GR
         VVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742201277; x=1742806077;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sivy2dFPDfrrWNy8pgqRVOZc7Oa4LQfVg4rx4RY+3RE=;
        b=cPhJF7bLyd0/pQZp72vMZjmxrTKjH2636t/FFjwbsYIMNCjlwJQ/n7tVfnl0tY2Y8r
         Lzt2AdRoJ8YAMzmyza3Khgy/khXG+vu//Bxz2ZXJyV+8CnXk3elCHvWqsuzu7U4QlaE5
         REkNc92bbZZgOnR8BtyHOo5N/nf/BXJjuUzEvNOHLVbw7ZDgf6UfytK3xOCLHKzVfND7
         42RA1aRIkDH70LCEyIS3h8y1gTf+qXCQ9o74hdKoFFc1cvCpWg/qAxnU6/KiFG6QA7uK
         24Edp2XkogdWmwLsF+zYVE96HfkxeOhZ/B1tgDcFSir4ahDwVjx7apBRk8SOzplSQPkh
         VTqw==
X-Gm-Message-State: AOJu0YyrYqzEsTRUytzAmWDOupFtrafXNsXmtHBpz/CRZkLBElXIcPWA
	JTLFySxV/ecKFmDNAELkhD/9+PI8YfvSDHlY7iwneJ7NOjWM+0To
X-Gm-Gg: ASbGnctn67/AkoT7GaOqBu5cuY5yEhekEvdwb84JLqK9pXHLMEI82WQAmLszvXiYMws
	n/5G8w9njemw+tTnm5eJjq63adm7qCSJoXNw6zhSsi3chr2m/t7K20l1fBl7HTA7zxWngppDdj0
	R12TlFh+v5nXv5bYPvaLcTnAH79db+WFYeeciC/H4ZNFvKy7LS3bxaB1NfmdIANTC4WIO2hAyYw
	9MKghdAxcJt4FwVIel6FCc+ckeXJNgxldr4C2QZoHAcdQQ9rOpaemPXVpjFXF6HJksAIP0LteGm
	KTF8Ir8i7fxT87HUP8CghT9Xp27Ol50c6w36DTJUVSscACSj/+ygoZJaqhKqjDv48reljYN/VO8
	W1i4q1BTZBNeXNXlah8wpnZk2RvaWRgAEEfMF0XCl7r4=
X-Google-Smtp-Source: AGHT+IHWG4ioeUkKOqbyjHVa3nGcDKasGMk84coU/EEXrQ9CgoA9EeOa+Ei+KVhgfcSMQroZdbmSgQ==
X-Received: by 2002:a17:907:7296:b0:abf:6e22:cac7 with SMTP id a640c23a62f3a-ac330263c1dmr1241552766b.15.1742201277303;
        Mon, 17 Mar 2025 01:47:57 -0700 (PDT)
Received: from alb3rt0-ThinkPad-P15-Gen-1 (host-81-118-90-13.business.telecomitalia.it. [81.118.90.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aea41sm622028666b.28.2025.03.17.01.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 01:47:57 -0700 (PDT)
Date: Mon, 17 Mar 2025 09:47:53 +0100
From: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
To: shawnguo@kernel.org
Cc: linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: OCOTP and DWMAC builtin modules are needed for imx93-11x11-evk
 kernel dev via TFTP and NFS
Message-ID: <Z9fhuVltKwqgHdLp@alb3rt0-ThinkPad-P15-Gen-1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

While playing with linux-next and imx93-11x11-evk via NFS and TFTP
I found that the dwmac-imx, nvmem-imx-ocotp-ele drivers by default are
not builtin then the I was not able to reach userland. 

The following configs were needed to reach my goal:
CONFIG_DWMAC_IMX8=y
CONFIG_STMMAC_ETH=y
CONFIG_NVMEM_IMX_OCOTP_ELE=y

is that something expected?

Regards,
Alberto

