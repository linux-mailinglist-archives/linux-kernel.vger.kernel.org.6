Return-Path: <linux-kernel+bounces-344968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 842F298B0C1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62D71C2138E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB0C188A3B;
	Mon, 30 Sep 2024 23:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+xqS8gj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7F1187322
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727738539; cv=none; b=TqX/f/8EMX0cFyICGqD+FlKHbex+V2/Vc2aZkv2oP35D06VKVO7RrEbMu6utEgokzjkSNnGJt28JXAHL4bHbvbi6fuwAF5g291afvDSzBtHsUgDj5idnN346d1ADX9CQY3dHHqZfX4DtDrGUXTim2XGJK7I5id4lkdPCJaAiyPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727738539; c=relaxed/simple;
	bh=5wMoQerhVfNthdnWkyVLl81spGHlLzs98yiY6oorZLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rPoHLQMxELws1XzyaS9PRk2Cklo1zilbsg0+WdjqSCnpYae/gZEHJDFBul8rB5iAHUHL5i/04YX4gBOp5Jl337rQCCkctto+9revK+SXPDkySznHBxmkTkpDtYKxCxTnUgaQr3D25SuSaxVKMPq0RK0vGEDH/R4Y7GlwfxC96ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O+xqS8gj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727738537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cw3TyvDfm5lZoBfW+yqVxJ0cUAPR/u8ZzH97gvuXA9Q=;
	b=O+xqS8gj1hMA6E88XbXpWfcDLXduYuoOrrB6l2pS3vG1Jgs9JxbPfPhOlOJsSOqpDzANBS
	9kPOG0c2R1/31G/97gWmZOTprX+6UsJ8P/eOplpwpY3kA8sPKUecjADltERSLH7eH83J7B
	u22FHQ29+QbKbjGFQDODYuX7PmMWzk0=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-0SuH_3luPlmP9TKFjUcakQ-1; Mon, 30 Sep 2024 19:22:15 -0400
X-MC-Unique: 0SuH_3luPlmP9TKFjUcakQ-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-20b4bb1edc0so26711085ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 16:22:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727738535; x=1728343335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cw3TyvDfm5lZoBfW+yqVxJ0cUAPR/u8ZzH97gvuXA9Q=;
        b=KUaJVLXLUIoVrbTPYjxf+fam6orQ/VGZCuc3kZcyQA3JdJp3/HGR9EFQmoZ8mlwPbq
         J82LbuJuCBkIsfZdIB/DtdggNjBYL2l9adrrtzxrGaQFYdcUyC2MpxqW2iMiagJXnTtJ
         aOrGnu7ssh790k8b2Tv/pqXzXoAoX2Ed/fQLejrZueiL+L0hCJ+c4u1+mDTJEdKKAhH/
         5INe/Xsloyw4+oXd7SZF6DZoxuYKiIUgRGl/lHdij8cugw7aak6rk2lG45a20t9Vx8wu
         p2mtLrzFbaKFS/ZPlGDBvxocsltRNNyyYdGExaiAEppsy4Wwb34xew2daXcgPOYajVkX
         8GSg==
X-Forwarded-Encrypted: i=1; AJvYcCX0tMDx8qbHsEGarc5FkeodVpQ/RlSn+VD7UpCJFVWdnaGG6uhdq5HT1ManVeYBBNpeRQ+ClnsgnN4VvaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR8ZISm5QMx01qN8aCRkBWWtrMnQdysyE+5tS74Y71UBo9tf9h
	OVQOpWbRbLajq0os1pkXsUYF9oUNpcXOOC9u5lxHI56hl/+y5YvZIJzI2TLk7i3j6qJV51HBFaG
	pb6SrT3AjHcSxSw2hXk2Pw4XeewNDRsNK0yCgtpbarTU0YMdgPKM6CBYiF8kSl5Iwa1/yqXGW
X-Received: by 2002:a17:902:ce88:b0:20b:9998:e2f4 with SMTP id d9443c01a7336-20b9998e604mr29141605ad.61.1727738534846;
        Mon, 30 Sep 2024 16:22:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFPJ0xdEclTCdVD0Cc7sUcJpQzyM5nnJoWiGEd7ndTGfu+IiZLg+4emBGAIZlH0JO0quOIjQ==
X-Received: by 2002:a17:902:ce88:b0:20b:9998:e2f4 with SMTP id d9443c01a7336-20b9998e604mr29141435ad.61.1727738534544;
        Mon, 30 Sep 2024 16:22:14 -0700 (PDT)
Received: from rhfedora.redhat.com ([71.217.60.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d685b9sm59241985ad.54.2024.09.30.16.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 16:22:14 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>,
	Thomas Renninger <trenn@suse.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-pm@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH 0/2] pm: cpupower: bindings: improve test script
Date: Mon, 30 Sep 2024 19:21:53 -0400
Message-ID: <20240930232158.29024-1-jwyatt@redhat.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve test_raw_pylibcpupower.py with some cleanup and catching more
states. This includes confirming states have been disabled and a notice to
use sudo.

John B. Wyatt IV (2):
  pm: cpupower: bindings: Improve disable c_state block
  pm: cpupower: bindings: Add test to confirm cpu state is disabled

 .../bindings/python/test_raw_pylibcpupower.py | 28 +++++++++++++++----
 1 file changed, 22 insertions(+), 6 deletions(-)

-- 
2.46.2


