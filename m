Return-Path: <linux-kernel+bounces-312161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4CF9692E7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 06:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF9892834DA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 04:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D521A3048;
	Tue,  3 Sep 2024 04:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2JqPsf/"
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA35195
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 04:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725337965; cv=none; b=vFQjxQsuUNL29KbHErowIZUP74sST4Rxpi+fsmP0dN/IN6i3nziMVB85A/D6qtZUZD5iIKSCGOP+PxhUrtvORotuhxjPUFAoez0Y9D/IuvNSa713BA+tveUCxFzlfUudMTpZQulYe8aX9nyktCgXYza+Dt4Kp9lG6CZz3vuJPCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725337965; c=relaxed/simple;
	bh=gxGedeeDED5zUZNEmQ0u12y5SAZRF5xoQjNIH6fKQWg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sG1Ob7reh+Utcrsd8yNvDAVIhbRfRxwN48KQFkJJOiVvdhxxR4Htqb2FGiEaWlxun+f6bQ2CDWNUhzCJQzLVo1q2IR8Te9Ub1xMl+vH4XP4WNZFrPxM/+Cp3Q81eYmzrvwqucH4REdue+wlQlpCwEA6ehbzGECM4f5csJG2cQEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2JqPsf/; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-715cdc7a153so3338472b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 21:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725337963; x=1725942763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gxGedeeDED5zUZNEmQ0u12y5SAZRF5xoQjNIH6fKQWg=;
        b=m2JqPsf/FwI1UqJ+644YbI2x3mc1tFCM4Jp4QNlSq86vBoHPv0YOOOFIup9H6qyOOm
         eTX16YuoTBwDjOcQt5jzQFLKzOPeqkVDT+FBMjB6pl0h946I+xweAEz1gz96Prmuyii3
         zJdQ0wUiYJDjLBlybw+rzIglCTjKMXjLbgRk1DK4hrC1Uwm++mk53533xH7zq/VXnxR6
         MDbK/9Fe1QFjVSWExb6236xYk1Le36OOwfeggQ2yfJntID+AjpPVzTcLZ/h3flP/WwQU
         UdiajlSbK1STcpkIdl5A1K9pBg0jsfzvb3TlPlPhSuQo2jJ/AZ4ctxi/XZfk6XtH2mwl
         ZG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725337963; x=1725942763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gxGedeeDED5zUZNEmQ0u12y5SAZRF5xoQjNIH6fKQWg=;
        b=WEgd1rHqH1Yvg4CtDpKJ0uBdh2SEy1VjiNE2p+stDWg+qD6MGroogAP2dNl0PZA17H
         Q7UrD6eMCwkWpwnK1NZCLSIms2EY5iwuBEorBf2vpLziMnzdUPT5UgYdl2/pjaHADxGR
         eIkGx72pR7DpR3ukhDBEor6XG6I1nOtXbo5Ro//6c8ZJ2pHxiqbgzZDGLR2Xy0dlgNRg
         rCet4HtcFPBnKsjojS+328eZ3Sw4tiPt36yaFWIUV4CvWN7Gpz3U+JmRFRhunBKZUdmI
         NJFB2YcURLVp1edZARdoeLxfBOO7oTH7B75gZ2ii9T22aSEfojqSROkaCw7w8zUARM8j
         zm6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzMbAZzKgudyVkMU2+CTVaQ5uf0t6TzfbNGwzjRzY+cmjX6DBU31625Ppu2Cd6dJ/9SG0JTQYyCjiEYBw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9ck9KLD8jB89+bAf9NqmAcqOH4DmO72v5+q/l602c8/bH5c2E
	57LBd7SvHb2Ek1k3wVxKGlnexfKadq1z+RNYyYcqcQE8aYt+2eRVrO8cHAkI
X-Google-Smtp-Source: AGHT+IHEzpI+x8Gh3YfdqpVMWLjkIoWG10ToGyhe9LL5WYqxrMWvmnmA/8NySiILESGw/y3/D94m1w==
X-Received: by 2002:a05:6a21:10b:b0:1c4:779b:fb02 with SMTP id adf61e73a8af0-1ccee886705mr19871351637.21.1725337963623;
        Mon, 02 Sep 2024 21:32:43 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e575b5d5sm7624303b3a.186.2024.09.02.21.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 21:32:43 -0700 (PDT)
From: xu xin <xu.xin.sc@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To: shr@devkernel.io
Cc: david@redhat.com,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	hughd@google.com,
	xu.xin16@zte.com.cn
Subject: Re: [PATCH 0/3] mm/ksm: Support controlling KSM with PID
Date: Tue,  3 Sep 2024 04:32:40 +0000
Message-Id: <20240903043240.1776614-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

In the field of embedded Linux for cost considerations, resources including
cpu and memory, are often not very sufficient, so the global deployment of
KSM can be a mitigation strategy, which is feasible for closed system
(scenarios without Internet connection). However, KSM has a side effect of
increasing write time replication latency, which is somewhat unacceptable
for latency sensitive applications. Therefore, it can be combined with the
QoS of the business tasks to dynamically close some part of those already
started processes in real time if the QoS degrade. Although it is also
beneficial for server/cloud OS, the requirement of embedded system is more
urgent and strong compared to cloud or server operating systems with
sufficient memory.

