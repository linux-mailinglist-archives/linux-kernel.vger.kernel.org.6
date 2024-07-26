Return-Path: <linux-kernel+bounces-263816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 327A793DADD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E53EE284610
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D63C14F118;
	Fri, 26 Jul 2024 22:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="D+U4pBgO"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F218F812
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 22:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722034554; cv=none; b=m8XEmmCP8uf211+QNTGz4qBeujqahavoerFnknJ1xHPh2hVCTBlmjCSoysJnH+y1vV7+w2g8tWz260OHDsvZ7c5nJRPITiZovTnbmUajbAoFVEbROe+owqQz0QmJlf8qheFfC+GBwSrbkzFBVBao6EmDPpVWk7qslb3z+DEJRz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722034554; c=relaxed/simple;
	bh=q1UpuYWjA0m6cJZL5f2zlwjC8Sgf7Syi0H11qA+WQhI=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=LkgZ0g4XgIsnLqEekrzuuzz8JXPUP7vOseN+tAfZTIXA2ZY7Z+GmoL3QOa6J+6apLxrTzbHAObNej2f9xQMnKFBuSbRYqyvs+sD5SdLGydElvxiWwsYG6Yw4rmiirW5/W2x9G0g4acq830R3yldDOQ1XVNJsvwpwjl19jGEKp+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=D+U4pBgO; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d1cbbeeaeso1228413b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 15:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1722034552; x=1722639352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I+ffwzrPrpDXKhvcgWNKPnQUHaAqmDlPHmBlo4+ylPQ=;
        b=D+U4pBgOXBqqfR+OWjVmCl9lwDur4QjfxE/QL+jMLLH7WPezQGf9SM8cE2XzBmM85+
         0TNogXVCo/8b9eJn6n0zzQ/mkPX50GzIbBjZjVIirtLTHlgXt7vM2cgFWzW6EGqmFUjC
         7bqdHFVZlqb2MW5B7gzqbgIZRUa73VdL+ChQsOCQ3TgwGVeXnTe7fqRkhCYvVWytnUMG
         +5TFmlsX8oNFGXnjOaeQ7bnyka3XilHJjZ7meTqO95SS0v4yj7FS7D2eYjv80qRkQQyw
         AbXaMhqzNmeL/jqWQQwsycaok29vqxYXQEY0hYWr/aMbDn5CTvsKf5Wqqsns/rLlVU0+
         TH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722034552; x=1722639352;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+ffwzrPrpDXKhvcgWNKPnQUHaAqmDlPHmBlo4+ylPQ=;
        b=fKWdnXOcSTNCKn/0L+sYsOBBkrIJ9JvBfycCDeX94719SIRe1+Bz1duMViTf5WotzX
         oM8xyrwAFGS8k84nUFRCb0mXLhCkBIoPOx7UpGkhjZHPmVxgCOEMFk6obDgf3GrRypyw
         gQD5EVdrX5B1ld3dgcp5G3mGDzcUSFIEzXc2R+3S/lZ+w0KIjGiobWbS11GUaOllA56S
         r1bjAZbsTFqDu+qVxqkxRxXeaJfu+BRGn1nYcv2Sbbk3yJXnJbe5qX9nZ3545VYF9XJC
         6Nof+R694i/FSi+zQSjAPuivy3gkJObLIPYecvW6+yQHBaavGcudijpl5soyeTZrA9gD
         iVfw==
X-Forwarded-Encrypted: i=1; AJvYcCWSCO+wRlIk6D//7tzaZV5aXNy8DFAmFBvTlnpHRy64vUFW4ZnCqdEdCaXhZ2KLA7dmg5YOLzEyeXze2QY/FQLMHpiasT1UjOAXs8Nm
X-Gm-Message-State: AOJu0YxX7Vf0h/I9rtGT9Nbjny3gsaoOWC8XVk6/k8DjoLGmvKt8nOvE
	2oQFsQXEPIt28fjzO2VrBRkA3q+Sq6PvBIkFcvTKmVgYE8/CIZEdcORgHI4bxhk=
X-Google-Smtp-Source: AGHT+IE1nUFJE09RkD/KVfWEXdc6pIoLYdJNQvd3JzwSJ2Wh7bUrP6PtrhRnc9txFPM/2Vq/32+mUQ==
X-Received: by 2002:a05:6a00:3d14:b0:70d:2a4d:2ec8 with SMTP id d2e1a72fcca58-70ecea0e505mr1246609b3a.11.1722034552109;
        Fri, 26 Jul 2024 15:55:52 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8122e8sm3195857b3a.139.2024.07.26.15.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 15:55:51 -0700 (PDT)
Date: Fri, 26 Jul 2024 15:55:51 -0700 (PDT)
X-Google-Original-Date: Fri, 26 Jul 2024 15:55:49 PDT (-0700)
Subject:     Re: linux-next: duplicate patch in the risc-v tree
In-Reply-To: <20240726075921.4e7719d9@canb.auug.org.au>
CC: Paul Walmsley <paul@pwsan.com>, linux-kernel@vger.kernel.org,
  linux-next@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <mhng-2729a5c8-a648-4585-aa3c-dcbc40a5ffae@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Thu, 25 Jul 2024 14:59:21 PDT (-0700), Stephen Rothwell wrote:
> Hi all,
>
> The following commit is also in Linus Torvalds' tree as a different commit
> (but the same patch):
>
>   96333a020615 ("irqchip/riscv-intc: Remove asmlinkage")

Sorry, I guess I hadn't noticed this was picked up via irqchip.  I 
dropped it.

>
> -- 
> Cheers,
> Stephen Rothwell

