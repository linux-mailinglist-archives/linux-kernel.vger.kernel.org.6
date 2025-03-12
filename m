Return-Path: <linux-kernel+bounces-558478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5008CA5E678
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93E4016ACA9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263171EFFA2;
	Wed, 12 Mar 2025 21:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Rc1pNXbF"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2049D1EF0B2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 21:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814577; cv=none; b=NTO73krT1SGsM5wzOR7mKIV/U9TLzRfzW6GdyiFVWJxISi9B/FaQuFd4Gt9/D2QDNlGARLDqTNlwaDPYe5+0Q5ATNWfTI0OHfhPXr/JAZ076jznuQ2qI6NUXc3T1M93/ti71DBrADFIqIPA930KV787jtipCAqUn0cTLJ4wdO50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814577; c=relaxed/simple;
	bh=6cBhe/0J0x7XG16Ij8KWWPYPemaK8pVTxylYk+O6p0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H7hH8QYwDxwuF7I+1b1KZsZxV8z1MaPKEhuzKfkTs7wRi/8P+s6NNWRCXvUXNtBl11sDGvO92RCMn9lFJxNu++XiPa/jyYS2ZikN9cl3LUJaeqvujAGGPmvj58zoCeIMogWviTh9NOPjHWUbSj8ic4H3F0d1f5Tgpj3VdX9fES8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Rc1pNXbF; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D87FD3F1F4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 21:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741814563;
	bh=UYHE7PfrFzAetCRzPVVNsPinECVfo2Zm0WG/ZDMIyJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=Rc1pNXbFbnXXCbTzwMpSkrJv9F+x6BA5D2j9tVs9bxHaaOP4BoMneWMVkCzwLrRy8
	 4WunHHnuh+eTZghZZI9PZXrKjPeVPfOOFB5V4ef0D05pbWwmbarOQ9u2c6bazz5A+O
	 oLKtEWr7+pdiZEJrzWL/m9edy983t18LjHo8oZOVt0jpo4HnVFXmHmN2lMCgWoXU2N
	 kpW8goWoxVlE9pY4GF5RIBymc4B5G2CIwLrMsnaNwM2ztsModpVt0S+x/JJkS590+G
	 frN21DvvN4WsboKU4MixRfr7VXhM9xIZ3QJJr+9TfXvqJV9EGrU8ZHELYC4Pi31/J9
	 qS0jv52lhsDCA==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff798e8c90so478551a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741814562; x=1742419362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UYHE7PfrFzAetCRzPVVNsPinECVfo2Zm0WG/ZDMIyJE=;
        b=QIEn6SCc2xd16PKdE37U+gw/nZolg6t2wBrWDwF500Xqiq4LTa0Fgtl9njZeWMy8jP
         aPs2cWEqvA+QCsF7mVMPS+He+8go2GpNLV5aSpQ0ASoh9h9CEjcAaZ8/10bod2nlcSg5
         afZL2GshrUUu7dijv+HG4IvzSCxwlwDQz66LU4Ddj9uRTZQnNO+JrlbIOxgjYMvrW+8Z
         fNJrN+vYOr/ofsTytAieuDmRcBdZf1SWmalS4szuRI84FNTmj4FR/KF9HEsAzvIPHEAH
         v/xWFd/w15P/4X9YG0c5C8V63Q1teQ7tCGbE1B7L/HE8WKA9ipkDFKLQM7VocbuFS0A+
         kLWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2SalaQKQNo3oItvKuE2MxuWRdonfdMjcIxZAcut4agqo9G69m+MVkeMZjyOJXmN9llLgYTH+9wZnMBm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDMoVKAc87bA0PHtCiWlf1UxGnnCnmO2Bb1AOqQXJeZ7LrDu4C
	IfwlS1YLjFIgZuiqyTHjs0F5ZHNp1lcDo1+61ya1AkEV5LGPhBRmTT2b8hJ3WG6dQKjooylbPnp
	Xgbb1yl0geabeTWQYYXjWVfYdr5C+rmrvX56v9Aa5UPNPYPPeK3SlTHkpijlBakz03DfekSb8mC
	0q0g==
X-Gm-Gg: ASbGncuk4qr6c9Lf7Rjel6HHfRctpMNxEXvulx3ddlQJxZ2eHfVciSBUg6LuiKJqij8
	+LJjrrJ11JWLKk9e9AadswjCVMmqJxk4slfuTL2sW9e3zcn24anOJw0KJZ7iibR5NvDaF1frNIi
	BRefNLkCjxcA1bZVxikEkIbT6R7wIIOMsqmiMkljP4T90w7WY9vGB8MQO2RXB64Lg2i3E3CSchE
	t4/68p7ca9IjdBfR3RJv+XQrzR8fhdb1qDenIT/FDh4M1AeTQ2Nei7Y3/s1xh9PLZCeYiiHpXpk
	F1TpeH4beyT19yS/8ucuFuzP0E/JlFGLEI0pMAP4e2ItcQ9KuKpdgwEetjwO2YzoPYb0fZ0=
X-Received: by 2002:a17:90b:1d8c:b0:2ee:f677:aa14 with SMTP id 98e67ed59e1d1-2ff7ce6ff9dmr33955133a91.13.1741814562178;
        Wed, 12 Mar 2025 14:22:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESqd74aQLaRYMlhUC52mOCTMPtX58VJpqPHYNlhWsmVgCtfWUR4bux5MtYAMon8vBiSS29gA==
X-Received: by 2002:a17:90b:1d8c:b0:2ee:f677:aa14 with SMTP id 98e67ed59e1d1-2ff7ce6ff9dmr33955108a91.13.1741814561871;
        Wed, 12 Mar 2025 14:22:41 -0700 (PDT)
Received: from ryan-lee-laptop-13-amd.. (c-76-103-38-92.hsd1.ca.comcast.net. [76.103.38.92])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301190b98b7sm2353887a91.32.2025.03.12.14.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:22:41 -0700 (PDT)
From: Ryan Lee <ryan.lee@canonical.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Cc: Ryan Lee <ryan.lee@canonical.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH 0/6] fs, lsm: mediate O_PATH fd creation in file_open hook
Date: Wed, 12 Mar 2025 14:21:40 -0700
Message-ID: <20250312212148.274205-1-ryan.lee@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calls to the openat(2) family of syscalls are mediated by the file_open LSM
hook, but the opening of O_PATH file descriptors completely bypasses LSM
mediation, preventing LSMs from initializing LSM file security context
blobs for such file descriptors for use in other mediation hooks.

This patchset enables mediation of O_PATH file descriptors through the
file_open hook and updates the LSMs using that hook to unconditionally
allow creation of O_PATH fds, in order to preserve the existing behavior.
However, the LSM patches are primarily meant as a starting point for
discussions on how each one wants to handle O_PATH fd creation.

Ryan Lee (6):
  fs: invoke LSM file_open hook in do_dentry_open for O_PATH fds as well
  apparmor: explicitly skip mediation of O_PATH file descriptors
  landlock: explicitly skip mediation of O_PATH file descriptors
  selinux: explicitly skip mediation of O_PATH file descriptors
  smack: explicitly skip mediation of O_PATH file descriptors
  tomoyo: explicitly skip mediation of O_PATH file descriptors

 fs/open.c                  |  7 ++++++-
 security/apparmor/lsm.c    | 10 ++++++++++
 security/landlock/fs.c     |  8 ++++++++
 security/selinux/hooks.c   |  5 +++++
 security/smack/smack_lsm.c |  4 ++++
 security/tomoyo/file.c     |  4 ++++
 6 files changed, 37 insertions(+), 1 deletion(-)

-- 
2.43.0


