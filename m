Return-Path: <linux-kernel+bounces-439720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9829EB31A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33FDB2836A8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A081ACED0;
	Tue, 10 Dec 2024 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="F/9k4yMr"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21551A9B3F
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840646; cv=none; b=EbuBfb0NmET/A61I36yW9BM++bxkh+9HUOs1x2TLwzzPYhAARPtJ/FUPDr6/9t7htthBlzRMWQ652uXH+HW9+2OphVflgA4R7NCzJy1FEe0RO5+fTwj6MMdazxKbZKfI0xspSdl9YqAVsvnaNQH73EMnEzSWZhV0H8ku68yofkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840646; c=relaxed/simple;
	bh=qbnpLn4BZ5qmrBKCdPRddqkdDLGvHqs+bMD/aLYwtJg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=WWdMoXxreNs4ZnMvHdTtHiV0IY8X/mJ94JoIODXNeN1zHnPFYJh50TZa2/7tgTlm+/uhaIus3UEWhP9mW9VOFJIMWAZo27s+wIDdfIyBi+V7/s+XhnO0oV3r/0FXNrmW0ldupxCMc8CjHqGTLjgN4RCiopE982xd+DOEXveBZAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=F/9k4yMr; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ef28f07dbaso4127801a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1733840644; x=1734445444; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfNaO8Mq3fUpMH7rj4C1ZxDplvSUEAGODha6BIuTIq4=;
        b=F/9k4yMre3LP8KKr+kiFa8desBBF5bSXIQESiyQDoioGpfLy9Cs89idEhr/pcWJRV4
         m0wIWNyYF2PR3NXN/QtUn8ZtdAHzc4NcNXQT8WpSzL839pH6CvbB9W+gWg1hmnwFcnch
         ATToX3f2vc0Zw2iauCYOqjcHME2GDBOtz2ZkdRClyc7ZeoGc+sC97gFDkBjUxb2OfHle
         oUuuZ/n7dge/OikCk5HzfvHHz8PIbrDzKFtxludaaJDVgSa/EMIHITfRzMY8VLLn+KA5
         CJxK5lw+uC33do3qgfmlJuSjhlLUkZQSA2DF+NqDBkFi1BSD8+PXWGE1TlYGr03aCvi5
         rd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733840644; x=1734445444;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfNaO8Mq3fUpMH7rj4C1ZxDplvSUEAGODha6BIuTIq4=;
        b=V/hHRFjBndL3rcHHm9B9gHAEs6wljoyg7RF6lK/dGDF0NCiN/hdM17hatIA2Gb1JIM
         afZMjAC+YfWXUOPPh9sEHXJVRO4mwanJgWAzCsyiGMFt2NueeDu8gnL14ghUnj4w/hwE
         Ya2Xfbjszp2A7kAQLJPtvO8V7EPT73WyP8PRFplgh4NGeuaPsuD2LJopJj0E7MCUPR/d
         bVEeht14W8Z9NiXnybdT6fe/1JU30VEJ31mhs37IA71qx8nXi+YOzHyoxxpUioxNA7Vs
         PFcB3CZTCFU5CEjALVCgv3Kl4JTXWEPg3S/MQAZ/tjTYOZ+mjiszofxHkeBVua38W926
         1GfA==
X-Gm-Message-State: AOJu0YzNAt4K8iplg4JxJouYG4W4pBuUTYk00mABMUhPBjDr01xjPW7e
	e2MtK8aNU5Qj1wKMLsdTVbyim44E23UryO6+WApMzyFO+fmRsYXxUabw0lh1o/5K5+PQOy6ND82
	mV78afGWpN7qTP98xWpWONJk+Bhf8Br7iYAlz4N3jghwmyDcvZMj7fVSR0uPQffFy4kzk24cBzm
	htv4ZrWk1VQFANraEBfP3zuZt7YZBfFrI0RfeEHa3RIzt3lp4bGfilFQ==
X-Gm-Gg: ASbGnct/mIWaa2oY0/DBnYDsG6uLxhqO0UsisZPewZsMdsdVw2Uw7BraJIdZBddJmP2
	kXpWEd6llWf3ieIwHr8kBGculcEwojyYY9r3869P1wCSBZOYN1GtSBcTjRPtxYYDiQPKl0yISu7
	hpo9xDxHj6NiH0t497i14cx0IH8GPskAVhd0jj2jjtF60hE2jtUmGXB559vawQlLSdk/BD96UrS
	lMsE3rjxdqzqamKDYkpL7taNu5x5qc6qAFrx49b1xlGV+fQweHaVAVzbjJXzD2dvhSDgP/8Wc9t
	EQ8dfjlq
X-Google-Smtp-Source: AGHT+IFnc/zixc/JgDTcHtzlQVoMukDdzG1nRXyNA0lRBdlSoY0qXoGZ/QEbwpUGsoPatPxmJpVdEQ==
X-Received: by 2002:a17:90b:4d0d:b0:2ee:a76a:830 with SMTP id 98e67ed59e1d1-2efcf222499mr7432347a91.24.1733840643779;
        Tue, 10 Dec 2024 06:24:03 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef7315fd3asm7538444a91.44.2024.12.10.06.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 06:24:03 -0800 (PST)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: greentime.hu@sifive.com,
	vincent.chen@sifive.com,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH 0/2] riscv: signal: fix the size of signal frame
Date: Tue, 10 Dec 2024 22:23:48 +0800
Message-Id: <20241210142353.6457-1-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This series addresses two issues about the RISC-V signal frame size
calculation. PATCH1 removes the unnecessary header preservation for the END
header. PATCH2 refactors the estimation of the signal_minsigstksz.

Yong-Xuan Wang (2):
  riscv: signal: fix signal frame size
  riscv: signal: fix signal_minsigstksz

 arch/riscv/kernel/signal.c | 46 +++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 21 deletions(-)

-- 
2.17.1


