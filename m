Return-Path: <linux-kernel+bounces-255313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D58B7933ED8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 905EB28376F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5683F18132F;
	Wed, 17 Jul 2024 14:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1MPIB6x"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D80180A6A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721227882; cv=none; b=ObJVvCXVmSZHApBp+Htf46meSJSfhfPgL9AESUDd3FzIjnabwIUiFJVMUAeGQd2CkskvmChrGvZWXsv53mBdAhuTC5vlJuDAh9N++4guDqXY9Nfn39UVnEunq2JyJ+7KYl9ZD1C00U87P4+jX15p/FETWm0mso2l+EIMCWT0NM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721227882; c=relaxed/simple;
	bh=XRYe6k301hVMrjUu3bWA/ITB1UE99EqwDnjHlWIAJ5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=flSdFCp2wSToeC1k380AJ2nm94Vh1R/C92r37flMHCWjgGCRX6ZT1nfCcaLyrIk516HX8XCXKKjZQ3pP2upD3mY+43tS64BGV/SarwPcQJdHkRpzP0M8zrBFL07LSIDxcOgF0K1LtdZaFscCUR2x0CA7pFClreKVE/1BZOsNj4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1MPIB6x; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2cb4b75a150so635540a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721227881; x=1721832681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRYe6k301hVMrjUu3bWA/ITB1UE99EqwDnjHlWIAJ5k=;
        b=i1MPIB6x/XudVHm5ksxOrn8oP/aeIM3MGiCnPojyWpHdQzoYKBpa0Pvr8/kW/55LYZ
         BvWjJ5T8EgXFnq2XFPd/VPnh5ZRJWha35tD9X47L6u1omiXhL1gi9zXIrEPsFrgYyyYi
         1KphVffBjKEAvWDrIcjn/LjwXjzzqyMzRNax4LCY53JWJIV6mZvwsxwbNRdzUmw/dGPl
         ydLFkMfTj9M7Nrg9cBp65y8aCHWkTGAYIzhgGfZZ7p3eJH0u4dkNtL5FyrtjGG5wF3X1
         CIMJZcDdwm7ovlRImzi9cnBk7cnAcs7ppY25HlwsWxzt2M5JyXB8WR+c1qDYurGfdL90
         k5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721227881; x=1721832681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRYe6k301hVMrjUu3bWA/ITB1UE99EqwDnjHlWIAJ5k=;
        b=KL6EPl2XHRZgvzBV6ijHfFbTidRBX+PC5ZZiQq68jDVPzVjNVhgYSRedfh2gaN5rQA
         em3/tN7+V2M9jCtz9hX1g6bv8TM4b7LsjyXSrQhUC0LMRXdOv0P8IUnxz2h3P3w0b9pi
         i2RkDg/VwYVSgHg4lGmbSR2JLIseaXlJ41u1XKAn0n7UY4U0p5IqSZH3jvgm9KVVV/sF
         ASs3UvAqSdCTk7LnvyN4QxT1CRS1f6/Tstd7kNJbA3m9HBAI9gkWDX7iizRjSQG37u/u
         2CalmY5wgXUrIZ+DxxEbSQQfmJcNVQCw+krLCB3q1iZVxgt+ypMyeP/m3wMgUyGCmgep
         D+hw==
X-Gm-Message-State: AOJu0Yxlm4Kt1WA4jidjjASwaC9i/pWMVMTI430eAnko+8DaEjjsWZKt
	3iAP3FK8k9tYgHA70NlU9WLXVrXDSBi1ECBGBOJB2qnzHv4qyIsg
X-Google-Smtp-Source: AGHT+IFzBQApJfDtVZSjHvWylGDQrFtwfnApHHiZeaH5cGIbrnS1T9c2rr2gcgJjRWoSldlTvJUrVA==
X-Received: by 2002:a17:90a:c28d:b0:2c7:8a94:215d with SMTP id 98e67ed59e1d1-2cb5268fff4mr1447884a91.12.1721227880645;
        Wed, 17 Jul 2024 07:51:20 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb600f9db0sm22082a91.14.2024.07.17.07.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 07:51:20 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in hsr_get_node (3)
Date: Wed, 17 Jul 2024 23:51:15 +0900
Message-Id: <20240717145115.9515-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0000000000004a86bf0616571fc7@google.com>
References: <0000000000004a86bf0616571fc7@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

