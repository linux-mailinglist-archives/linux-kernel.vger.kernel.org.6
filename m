Return-Path: <linux-kernel+bounces-554274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EEBA59596
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EC617A1DC4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DED229B00;
	Mon, 10 Mar 2025 13:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vbu5Vu0U"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F03C17C91;
	Mon, 10 Mar 2025 13:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741612029; cv=none; b=JC+PRuUpFWT2ASrH0p7ynD64vdJrW06kofrFveoZ5GEzpJUPwcOlD5Y33AlQmNN0BqMIV19jfNC5B8cX7WjR/H5xlmkLSaasxoak6YjcsxyI0opiya1veS3o1AfL6PWrP+lFXD3bRwgiACFaan1RcvDiZF/3P1tcf+9M7/k/KtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741612029; c=relaxed/simple;
	bh=wXKpm0R8aaBJWgfXeH1+KgpzBqh49aGVJSotFIFZQBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BG29iCkQjt5AmCnHM8BztLKXsVQ35t3XIaUEaMHzR/BIYzK/78g+q0NeVtPTMIyGfpKWjgdfNMbS2PiwRoqgmQIjXCAnxbhMCuzpib8OSnyYQSPDKWWVaBdPIZX10iS7XWhKy4OPA1PzLIXNbNH3GVscXABGQ34foRddpM+Sa+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vbu5Vu0U; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-224191d92e4so68281045ad.3;
        Mon, 10 Mar 2025 06:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741612025; x=1742216825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWu7aiMIZT17b5x/ebZrxHZih6B9riko7vt98zmMSDo=;
        b=Vbu5Vu0U1PhPA34DhkJjyHSiy5PiwgnxeUw9ovznZyu4v0hM3KplDMqIPRZJwAnKNU
         4DYP97I+zHIDpmliZbBpsueLhkuuExjwJFzFg9VZdjXFn0pP8yj9KmaVRZ/sXpe1BYUS
         dGRTsvI11l1K6GPmSnhQFthjRl6RWbBEv3qPwElyRNpAIRPIDI1RONS5uH5Fhj/e3zG9
         qsUSonifSGwKMPWzjekDA8MOVJ62j6Yh54DEn7DW1loEeZ2Jb1HLoH2U61Q6qF3Mi5ih
         DelQLxhGmemus4VowqhILDNPM7sNyE90zvO4jT8KK8xGCLLkg2lQIfJQBk27xwcicknz
         MyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741612025; x=1742216825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWu7aiMIZT17b5x/ebZrxHZih6B9riko7vt98zmMSDo=;
        b=hD8t+DL6V6rESXYonfIUfRtc2OoaeY/TlhMiUPX6vUC9E6hy1HHnDPaZBr3sw/9nBL
         zpR+8sIyVX0y8L+jr0QNzq+UcNgH3HXnnbj0VKj7r2KAyobwT1Ug/cbiFRaquGQbQ8/I
         QMAPIA1hMeTyZxtQ06B4g0y4i9xA1Y68hb4HQBlMFXA7WZJG4NzpgKVjLYtlb6PdGYuf
         SZFf7QQlCsBuTEhaccN4TVAeKn+shj/GrTlD0aEMEHeStP5NYAg9YSKCPnzYNVJjFbCp
         MAiV9FNV0a2UtbX8QdQAxpR7MChZ3RZ2gyE6Edp5p1zuxF8JY8tKxX0NS2CYaVT7gr4O
         Wf6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgSGaQiKCSeeF6nDtfjmXtSj3CYFJUCd1KeU5rXFaE2edDRwA8/1DknyFKgXvdzE2N2ccrHe5chKFEIqw21Gw=@vger.kernel.org, AJvYcCXTaVwADXr66g6tNi2SKhfVb60QMYJVf+/SEFNn0zoNaq9E632BefuBOkEGdJQfsyT7C2z2KWuNASKPEJo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg2wDIkp7LIhuzH9zFiwAP8LHouDa26jrzNr/qTisUtP60A4o2
	lzOv4BZxXZRasIQJVfBbOawKwnvHxiZF2ktMD/BKarH/6O1D4HMz
X-Gm-Gg: ASbGnctqCgJSo7tsxyqQoXUmH7aViM2qleGFR3JJVG49ynWGjgrak2oqpsn0IoawGIB
	RVZNNVn3WlwlHpMyWou0UcWI9xJwIxVkL+OIPmbPgDK66e49x+wMVUGl6si749u0QFIjKhfSYQL
	BUMDcyuJ6grkTXTkiCwhk6phNSv8JnQt9vOeKjRFrhhMmdYAwO6WYnZZjODM4nsXU6BQCQRec+c
	YiXNimzrWokhVE2swF2ABt+H7HdmlXqDQO4y01YIBhbLJYJxLsMwNHTK83Bg2/mSMqTZCu9uWOF
	Iq2bdkRuFMZkWbaDh0OFXb5HBYgQH8Sc8/9hS3oRuj5izE9fzikO
X-Google-Smtp-Source: AGHT+IHhkHyOZNNCXbFMmLFwpXflDQNZuEKw/PQNSNv6nLwD0+sOO+cVRdre6nitAncCb47/EZZwVA==
X-Received: by 2002:a05:6a00:2351:b0:736:4fe0:2661 with SMTP id d2e1a72fcca58-736aaa079e4mr18667534b3a.11.1741612024866;
        Mon, 10 Mar 2025 06:07:04 -0700 (PDT)
Received: from linuxsimoes.. ([187.120.156.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736b8f55b9bsm5461256b3a.146.2025.03.10.06.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 06:07:04 -0700 (PDT)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: joe@perches.com
Cc: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	apw@canonical.com,
	arnd@arndb.de,
	aswinunni01@gmail.com,
	axboe@kernel.dk,
	benno.lossin@proton.me,
	bhelgaas@google.com,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	charmitro@posteo.net,
	dakr@kernel.org,
	dwaipayanray1@gmail.com,
	ethan.twardy@gmail.com,
	fujita.tomonori@gmail.com,
	gary@garyguo.net,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	lukas.bulwahn@gmail.com,
	ojeda@kernel.org,
	pbonzini@redhat.com,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu,
	trintaeoitogc@gmail.com,
	walmeida@microsoft.com
Subject: Re: [PATCH V9 2/2] checkpatch: check format of Vec<String> in modules
Date: Mon, 10 Mar 2025 10:06:50 -0300
Message-Id: <20250310130650.855103-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <8f8c79c5f1c5508defdd4a4c020c2c8e60b95afb.camel@perches.com>
References: <8f8c79c5f1c5508defdd4a4c020c2c8e60b95afb.camel@perches.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Joe Perches <joe@perches.com> wrote:
> What happens if the patch contains more than one module?
Sincerely I do not was test this. I don't was think about when the patch
contains more than one module, is a critical problem that went unnoticed by me.
Thanks for noticing this.
I will make some tests for this and make some changes if neccessary.

> spaces contains both spaces and tabs.
> Why not test the strings rather than the length?
> Otherwise tab-space is the same length as space-tab.
You is right, we can test the string rather than length. 

> Why is herevet_space_add more useful than herevet?
The $herevet_space_add store the $herevet for the added line. Otherwise, if the
change is like:
authors: [
+	 author_1
	author_2
	author_3
]
The $expected_spaces and $spaces will be filled in the "author_2" line. And the
content of $herevet will be "	author_2" rather than "+	 author_1".

How the rust-side patch already is merged in rust-next, I only will send a
patch for this checkpatch.
I will make this changes that you suggested for me, and send a new patch.

Thanks,
Guilherme

