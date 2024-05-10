Return-Path: <linux-kernel+bounces-176305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 871C98C2DB1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 01:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 334621F23BAC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 23:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42050176FAC;
	Fri, 10 May 2024 23:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pg2WHKhZ"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D6A171E69
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 23:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715385060; cv=none; b=CiO8RVnbwg8SY2NKauhsFpbfqI22H8aYPyGdHA+U7vi0bslkeG9yPmkO0tki8VOhfLtMCJbL54pJjYO3/H6JHDP8dFRcXU9crul1Ar0ECl5CxDVj4SagW/LJaqnHpEysnG7MUjZI1NwJZhpHjYeWCwYaz85zAYuFmHtcONPpPLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715385060; c=relaxed/simple;
	bh=XIArHrhr1h67TzOs3SLB/eIid6Ie6Ur1aeDIB7wF8vY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Buv7q6sUGiJlapMvQq6s9LHmFK69EnkA52WPhowi5PTvEtQwJdyUhUITMGmJFCHDcZxA78chHbdP9G5/hKhqCQbsF5OLHN80v9x7PtEjJdclkyO45Bq7uUIPq4TzopkGEzvpNParlAbNM3OvgmKLJEZNQml4g/q0OgoxRL0yZpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pg2WHKhZ; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5cf35636346so2023000a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 16:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715385059; x=1715989859; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XIArHrhr1h67TzOs3SLB/eIid6Ie6Ur1aeDIB7wF8vY=;
        b=Pg2WHKhZK8oB9u9P8mXFfWxELhUvDL9yGllhWwEGe9Qh3RsSDoYGstMUzJ2yKcmaOf
         g89SmfaeT9T4KBk+QHJid0GVSaX52o2uR2ymyYg9EQz6zdeAzk4LofCUMPFGcr2NMuQ1
         ExCc9t3T90CLXyOHirwnfrwVbtxfXgqe+Aj7bnMXbBBhT3qWvjzk9yUkTaKIqtHkI0hY
         9W204FD/u3bDnvIHa1fb421kIKksiT6iMWTktAmksXfPSqj/lZlLV68brxcAvejA6ZUU
         EU+sj3s2PfRP2p1H+EdbnYcRRlB9xoHJrkISDCszNJoMSN2SGB8wFmlaqPY6jUBV6yjj
         9q9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715385059; x=1715989859;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XIArHrhr1h67TzOs3SLB/eIid6Ie6Ur1aeDIB7wF8vY=;
        b=gSKBM/lxlIRCaynMVU/BMEGMopWFArrsJCIMA0uFHquLBRccFJGrqJbaSdRvP3lNOK
         IBA6+9XuhJ8Dyg0Sk9Yw4ImiFgy0euHX0gqs6v/ZgvvQ37kOcC+9gb1e77wy87A1YRv6
         llFQSKY8NkZlD4CPTpWjOyWEKsnOdUINkWDT5tPKro0mdIbmLsTQjo0BrrYwpKCpZk7h
         nw6NX6EX7lBoYlfIOHil0My+RdB3EeodUxtydIJvDU9deAHW1klWWl6S8hyDnEEIn0XP
         o6l2axDj2gTWzQpvzbV1h22lE/aoKXmBsemg5NLN5IqDeBCwzgpA1XbyddYW7FirKH+b
         wL4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU17Qd5RkwDdtvlNj26Zinmfq5cJxKZVlvMa2suwEubIWHG10nYrQwrkbxFjWJPvidmEXdrEjjoRBdIc9t/mTl7eV57tesOtZyc5jvc
X-Gm-Message-State: AOJu0YzXQ5RHNJTA66tnLpELLKkdvQ+I1koFUc5SB+DRsJI/h1cmX0GV
	qeLwr9N20cAixMSF6q2x/mV+thf6paXcXzXnVsVILQfnFsyJtrFeuUocYtTjLVDUqkotUIayjZ+
	cwg==
X-Google-Smtp-Source: AGHT+IGZDlLw97xSltLghqnuxWqKTMuyuG6MpY/UBTcl8qV1ZiOHru9f704DSjljZlFGzlFhUHQ3fTTBgmw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:3f8e:0:b0:5ce:13a6:3c36 with SMTP id
 41be03b00d2f7-637427aa267mr10046a12.11.1715385058206; Fri, 10 May 2024
 16:50:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 10 May 2024 16:50:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510235055.2811352-1-seanjc@google.com>
Subject: KVM: x86 pull requests for 6.10
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Nothing notable to say here, this mail exits purely to be the parent.

