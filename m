Return-Path: <linux-kernel+bounces-376027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4689A9A9EDE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D8EF1C220A2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509D51993A9;
	Tue, 22 Oct 2024 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLg1VXtB"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA84157487;
	Tue, 22 Oct 2024 09:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729590302; cv=none; b=EJGKk15hQOeAqf5a3ChMa9x6PHnGhroSKuzWjh3T2Ou9iXpbhQf/J077oWhLNrTRWTm2XeR/0LoIlagC/SLWvN508cq7/MJN+WbCjb3v6WrMfT/KXt53tj+nkBSG2HWqCicXlnfWaLD9nnNLtHlQoVfsJNBG9UjP0JVOZCFW6Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729590302; c=relaxed/simple;
	bh=mcsX0WXJKznvm/bkuqTU0BEtWKHXgcusKVsmdF542js=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N64E5CD/nme6Fp8cLJK/TxlnZG9t01ZhG/JZdjrGiyEpD0toLSdVmfsljLSVfI/WZzVOBBKNA6LMrkCgQRJ2C64Cue2dvg9sgVUUfqNFF1+wO8yIFWPmuMzo6zL6VaOaNLSYRVFYimefME/YuhRNPwDCAsXYB+3x1qQe0sf6WVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLg1VXtB; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ea8c4ce232so4541074a12.0;
        Tue, 22 Oct 2024 02:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729590301; x=1730195101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcsX0WXJKznvm/bkuqTU0BEtWKHXgcusKVsmdF542js=;
        b=ZLg1VXtBuBSHWcqP3QFnHxYWZE/uWvPWNvTAm5BJPez0fLS52QL1PcV6TFh28PVKi/
         7EQV7lmg9thqj2GepYl354f19hLaAbs1hn1H+xWPIGeEj/qMFBTUTcIXMW3/VtNqvpdl
         M8swFEEK18u4pChCdRqFyIksYzA57fKDPwGa9KEjhptAPIZjTfhBCAYdiQBI4cI0S0/+
         ErsY9LjNEyx7n/QboU2N/SB6LgFel3FkAMCsrc+931a3LquRVCUhRoO8SqthYgo3KrAM
         Znky+tT9XPhacI4WXa/6CK0OgKRiZOmMJbCSFPQabVGyoxFsP+moD5uGXrDJnPUSf9cw
         uJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729590301; x=1730195101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mcsX0WXJKznvm/bkuqTU0BEtWKHXgcusKVsmdF542js=;
        b=kCsa48UoePWWPRNYmj6tgLjhwBBxbjQGqVj2GzANKdMEJ2jr3b1mPqLvZJNLyYRuuL
         n7paYjXNRE5XNYhBYpjWcz6mzpwMfIYcFUFF8EARaQRZ0opLn5asfDIqZhFhgkZo/E9Y
         w01PyDgP18+5SSWFnw4P1b8s8xw8PFA0AX2EqG5shleC9gCV1A59WRYAHcZAgKlMNLjc
         xzR1abwmAZO+d0cmjODh6GfZTXSc+sylO9JMl/gnwuAqBekSMFoOvXg7BbN65C0Zf390
         fFFUjOcARKG95yMIurjpzM64UU4EOiITxWEsuJUz7NVngngB0VX9zGmwhb90pvQzzewp
         vvkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUX5E9po7iuSwUtaxKNrM3uKzYjni5M6V+e6bi4i1utrNvDxPypFPJCKz+A2wN8kF1HOARs8Y+/kQ5@vger.kernel.org, AJvYcCXWXc/sWXX2RxXPIfeIzMzMtakACD6uBsNtO2hMREyE2Dxr0uDHLHLrcc5CWG2SMg3yOAA8PLPCvZdzZw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvtU2JcvYCr2waVFBmdlA/J4ozctsx65AgfGBVgllJPN1YcbDZ
	GcFQO00mdj5L/lhXAkUi9r767Esg/uPBR/506zWONM1ctXct4bOR782NpmNR9EM=
X-Google-Smtp-Source: AGHT+IE9ZtbPOVFuRu/8X3sBmrBHZxh56xKV93Z4BQzQt2cOqB7MCeZw280LRnCNLa6bCuPEXvaoBg==
X-Received: by 2002:a05:6a20:b283:b0:1d9:3955:6e6a with SMTP id adf61e73a8af0-1d939556e8emr13101540637.22.1729590300517;
        Tue, 22 Oct 2024 02:45:00 -0700 (PDT)
Received: from asix-MS-7816.. ([2403:c300:5f03:e344:38d9:d69:6b54:1f6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d7638sm4348000b3a.120.2024.10.22.02.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 02:45:00 -0700 (PDT)
From: Tony Chung <tony467913@gmail.com>
To: gregkh@linuxfoundation.org
Cc: johan@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	tony467913@gmail.com
Subject: Re: [PATCH] usb: serial: mos7840: Add more kinds of baud rate support
Date: Tue, 22 Oct 2024 17:40:43 +0800
Message-Id: <20241022094041.70314-1-tony467913@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024102207-unmixed-caregiver-b9eb@gregkh>
References: <2024102207-unmixed-caregiver-b9eb@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for informing me. I'll split it and resend the patches.

Tony Chung

