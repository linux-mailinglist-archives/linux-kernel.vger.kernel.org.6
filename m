Return-Path: <linux-kernel+bounces-188074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2588CDCDF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 00:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FD951F24D9D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 22:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA805128393;
	Thu, 23 May 2024 22:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fk5GCNxh"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719F9823B0
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 22:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716503248; cv=none; b=lsPUrNM95BxRSOVingExLWLrrPj2odnHbbA0InEWQ3kQMGp32uhfRem/jqcqK/4QP+vldHnkwMI9sTy+I4N5gsAH3dVbgMJVdCKytx5Chwz3k/PpOQTkCD1e834Q1/dtbiZYln4m0azkJUS9KsGNisij0Wvj7T1sCjElUn6spk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716503248; c=relaxed/simple;
	bh=c0mUxdCgsi2KrVeRpxcSZB8MmwArsNnruIBgy6wP7iI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dnrQTp79Uc0zvIDwHSTMkYbGb31Nz1fO1Yy14woWZAgnASNOmUO+AH0pHFkrOhMqYr9xSWXVWM0UeogvVGaAUP/qLA/ZVAs+xnF/KN7nUNsRf7dvH0azufQn+CzXnsMQ/uwPZwWjzyfrsLIx57cf44zzN4fWJHZPjjK/7Nw7tMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fk5GCNxh; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41ff3a5af40so12625e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 15:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716503245; x=1717108045; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c0mUxdCgsi2KrVeRpxcSZB8MmwArsNnruIBgy6wP7iI=;
        b=Fk5GCNxhPiar+UgjNqjnKxi3IrfdHjW+vWX1rl0MwDv2tlTs+VPfAHSQd1NVMLJ/oj
         WdBIQh9qnx7y55/v7xKhuDVIVtlQB8E7EoJtsOFq8HuCOAZ6n7NK4wOHkFH0FOxN109P
         sMmfcWa5GWHiOvEv/ub+4QWHvduAa2wQDvMzvrNyXgnNu0GUYRXqiZ+nQqp5I3//awaa
         Kr6byBq2exfk0RwXSaZEYeMouLmyq1HR8Bq5qMpzRkf7Hkfap1fxczP6PYxOpS89vMB9
         Fov9woabWfVVxo7QZrjljmf01fb6NERXovNLbGUXP7cLU+A6ImjpOekKQ0qaH5IJLmWe
         JpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716503245; x=1717108045;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c0mUxdCgsi2KrVeRpxcSZB8MmwArsNnruIBgy6wP7iI=;
        b=PqugD/De6efaJe24uYG1BtNgbE0tnEu516JG8GXfOXP+qC/8x2fRe/GSSBLA6Kchmo
         7f9KgqSMU3Vy1bR5SE6F/J1UBIjyWZ4A6O1uFQzk4wguofQl0wi4YWpKZKRlwghPHd3l
         ECfhg9fQkzAiecO0LYjNIWMq1LE/sYloK/X9wfjnpsbk4zyy/gEg/ZDuMxQqECKffHpb
         129BGbW3GW6IDf/1OXJhrQdblLqPWynm1Cjs4dvNlxhXGUa971iAaVhpedcZD47oH6yA
         X2Jxj+jhQt9n7srxnc+9LNXzdmhg50U773Ho1CwdZKAyoCr/jT4wiQZC8S+gQbgaM71c
         6rbA==
X-Forwarded-Encrypted: i=1; AJvYcCUlT4MlckolPtgy8VQr9icdh30g3zdaxob0VS1wY8jLuS+cSJBpeNeDFDG9Eepf7FdFFBqTABOFkdVTalJVpqZSR8awpwH0NKTpZAQi
X-Gm-Message-State: AOJu0Yx0MvnzKHpORnzY8uhlAVQcEwBiJ8KJmN65nZuww6jrlURLRMJ9
	MjBPhgt/9f55YdGGqApdum5TwaroZ4dvAy0SNryjLi2LN2DNRPDP9TVKe9NGEQ6AoJwdFVS0ZaJ
	nzM2/gyQlMl42Ucehm1cWxUwEzt64PHSbzD7C
X-Google-Smtp-Source: AGHT+IFynCndXxQSRyQxEh3uszYlhUwS4moW4riJN/2gUPi0KmtIvL9iA7r73v9YHUvtIeizmNWwYHzCkJkFOKSr2sg=
X-Received: by 2002:a05:600c:3d8f:b0:41f:a15d:220a with SMTP id
 5b1f17b1804b1-42108625e09mr650055e9.4.1716503244634; Thu, 23 May 2024
 15:27:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAzPG9M+KNowPwkoYo+QftrN3u6zdN1cWq0XMvgS8UBEmWt+0g@mail.gmail.com>
 <20240510060826.44673-1-jtornosm@redhat.com>
In-Reply-To: <20240510060826.44673-1-jtornosm@redhat.com>
From: Jeffery Miller <jefferymiller@google.com>
Date: Thu, 23 May 2024 17:27:12 -0500
Message-ID: <CAAzPG9MMHoHjR=EAAM9Rgkaih9QjU08tF6d8JrjQ43td=-oAVA@mail.gmail.com>
Subject: Re: [PATCH v2] net: usb: ax88179_178a: avoid writing the mac address
 before first reading
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, inventor500@vivaldi.net, 
	jarkko.palviainen@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	stable@vger.kernel.org, vadim.fedorenko@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello Jose,
I can confirm that
https://lore.kernel.org/netdev/20240510090846.328201-1-jtornosm@redhat.com/
resolves the up/down link issue for me when applied to my 6.6 kernel.

Thank you for resolving the issue.

Regards,
Jeff

