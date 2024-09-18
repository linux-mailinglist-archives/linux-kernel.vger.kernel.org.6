Return-Path: <linux-kernel+bounces-332936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9A897C104
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 22:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACDA11C2155F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 20:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130061CB31E;
	Wed, 18 Sep 2024 20:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4fcEdtn9"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0057A1CA6AA
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 20:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726692840; cv=none; b=BQ0BPYtTZH3QUp0r2OWXc1ZN3eKgiu026BIgIqSfwGnhyKrHAtyZL13A63Dy+jghNAwpnE35KhOWrKPEp/tj0GtcvQEbEWTHPdrxwjtULTS5ggDFed3Z8k0oiVPo2coPbS7LZYrWBoYPmWpTil1fR7WX8PMo75uLONvWhdWqEZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726692840; c=relaxed/simple;
	bh=I0pmbmvVr6aVjOWkLeghyK73dRYtjeotDrFl5n0BGJg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BMWCSS9eqVmc+4CPDwzg1fLPfHAB3TVtORMebE+Zj7T6086JxI7NRTuR9x2gkvAwUuogAlb3jEgQElk89t9BJ61UQiYD0mrRYtvGaz3k4RFImrYknhmcrtxqiLMcEMk1LlG3o4WzhgoQoGBEMQ4lOg3CfHDNHA6mjIIF5p5L6J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4fcEdtn9; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1cefe6afc4so290334276.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 13:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726692838; x=1727297638; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CA6hUqY6qi77ambz+EsLwuKLN+krduAZlXqGe9OZvKs=;
        b=4fcEdtn9t/wf30vZjSwqTaBEcN4MmOYrd+3GAeAToQBpOnhYqTluCgwEPSH2FlKpzd
         pvcYVE29597ZOUjWqGE8ugh3F3La8ZWbXMVLCfbLKIkDpH1by9ezn4JfisN+m8PKCxCM
         TdDdvkBDZ4l9T9E9CrkbBRIHdzdPyclZmsaESEI8S9lQZn78oXrdU9XFf1k41k9LpiRW
         nptJiX7/gOkiLYBBCSniDONjYRVHyUJAbR8n6GL2M5+aUureTkHaiPJWwUZgpE8gsCoU
         VZWh20T3S3EMn6li8P6aUSD9NtVgZgOzqIOe9l7dQxgkFBFlS1Ddb/VFO590TN/GxHhB
         Jb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726692838; x=1727297638;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CA6hUqY6qi77ambz+EsLwuKLN+krduAZlXqGe9OZvKs=;
        b=l5dQcUoGWZBZKIfofxr7i7zWihpOfO7Uc0cylUKnrUK+7oGvxKaLMyBKaFMkQyvxsu
         TUgxyBrOAM6lSko+M16fGvDplJDU7VZYeYzXZtNlphm9kXfctbc2b/0fG9PcBG8Oi18C
         TICyGSRcrfWjcH87hY816CMJFT5pElpp+6Z45YUgwc9X8d2vpTpd+yMzxDegXtUFr+9E
         h1IH+l2kTzGh/fYStGtVP4PdBfuQp/xpnslS6egdhYVrImJ+iVuXsPBHapkb6k7Ei8br
         89A7V+zjOxV2fdssLyMTObXZ6wgn9X8RZNEOahzv+lQNlt89jt+Irqtf+KIediAMzylc
         wI2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXoYkOGIGQOWweoHZUpCbW1LstXUF73Ut7HkZ12Y+7/HeNgNa0Vwgj6M1lSmfHQS8C+mRHlZs82GR890s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeQiwjorC8zMMD1eL1nFRWZ5ULmWSSqVrT4/q+gveFK52EIsGH
	KKmOs5kn8qctQfo66uV89qqNoYDmQmpXMtMTRHngWLwKBCxQb/zlq8mRFsLeh0afecWtHu+33E+
	NnBUGgNtESVCDw1/SM07xPg==
X-Google-Smtp-Source: AGHT+IFCO0PcuLwNxHuDHXibkKk117xEQMYckf/X/31GvTsVERSFJBaexcoRDcoOq7AGt7ymvntaTnKDNUlLeAcNjw==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a25:8051:0:b0:e0b:bd79:3077 with SMTP
 id 3f1490d57ef6-e1db00f4576mr29350276.9.1726692838045; Wed, 18 Sep 2024
 13:53:58 -0700 (PDT)
Date: Wed, 18 Sep 2024 20:53:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240918205319.3517569-1-coltonlewis@google.com>
Subject: [PATCH v2 0/6] Extend pmu_counters_test to AMD CPUs
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Mingwei Zhang <mizhang@google.com>, Jinrong Liang <ljr.kernel@gmail.com>, 
	Jim Mattson <jmattson@google.com>, Aaron Lewis <aaronlewis@google.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Extend pmu_counters_test to AMD CPUs.

As the AMD PMU is quite different from Intel with different events and
feature sets, this series introduces a new code path to test it,
specifically focusing on the core counters including the
PerfCtrExtCore and PerfMonV2 features. Northbridge counters and cache
counters exist, but are not as important and can be deferred to a
later series.

The first patch is a bug fix that could be submitted separately.

The series has been tested on both Intel and AMD machines, but I have
not found an AMD machine old enough to lack PerfCtrExtCore. I have
made efforts that no part of the code has any dependency on its
presence.

I am aware of similar work in this direction done by Jinrong Liang
[1]. He told me he is not working on it currently and I am not
intruding by making my own submission.

[1] https://lore.kernel.org/kvm/20231121115457.76269-1-cloudliang@tencent.com/

v2:
* Test all combinations of VM setup rather than only the maximum
  allowed by hardware
* Add fixes tag to bug fix in patch 1
* Refine some names

v1:
https://lore.kernel.org/kvm/20240813164244.751597-1-coltonlewis@google.com/

Colton Lewis (6):
  KVM: x86: selftests: Fix typos in macro variable use
  KVM: x86: selftests: Define AMD PMU CPUID leaves
  KVM: x86: selftests: Set up AMD VM in pmu_counters_test
  KVM: x86: selftests: Test read/write core counters
  KVM: x86: selftests: Test core events
  KVM: x86: selftests: Test PerfMonV2

 .../selftests/kvm/include/x86_64/processor.h  |   7 +
 .../selftests/kvm/x86_64/pmu_counters_test.c  | 304 ++++++++++++++++--
 2 files changed, 277 insertions(+), 34 deletions(-)


base-commit: da3ea35007d0af457a0afc87e84fddaebc4e0b63
--
2.46.0.662.g92d0881bb0-goog

