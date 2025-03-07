Return-Path: <linux-kernel+bounces-551436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 286C0A56C61
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D0BB3AE70A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA8121D3FC;
	Fri,  7 Mar 2025 15:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muCUQIOq"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C8318DB09;
	Fri,  7 Mar 2025 15:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741362235; cv=none; b=kW3XkXs8A/XKf7pUITGk/KZoymyC224Gb6BCtTCSs/cZDsegT4wnnQChYZ0E9sCQAm5gDC5OEvr0W6xcTNM++O+/dpcvSd1PIx+AeUy4wo4TpSks46HVvVjDkVvplS7odnC9G8AGSapb20EMSK2rZdgxx3MKbXPwnyYa+XdxNiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741362235; c=relaxed/simple;
	bh=8Ntml2Sm/nvVtmwH68yQthsfn5zmCNmXmNrMDICic5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O3CNLlNR8gO4hVf7Il9DdKl/GagOECTMhdto+n6s/Q9+yCP9gDK9iF/GpeM2Ft+/uJp2ZMWbxWjtMGW0xxd9DDWLPtDF70m693pUtHB3QYrheTE0HBqar1ypsrRN7NVB2vuRH8jshqYdcnOiYyKPLRwP0va2iAHjqtfTaYk9g94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=muCUQIOq; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22401f4d35aso38158085ad.2;
        Fri, 07 Mar 2025 07:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741362234; x=1741967034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Ntml2Sm/nvVtmwH68yQthsfn5zmCNmXmNrMDICic5M=;
        b=muCUQIOqpn4LLsxcBfkp/oayuP8BKQLoWZiUyTdfX1hvzmNUrQhTXUhvScx+6PN/p5
         gZ3mkO42SLv6L3rNvj2aqLg25RFtxIznQGJTAJOYx2w3eiyEIF6EH9DweRoLjDTcYIVi
         gcBmVB3cvYZYI2bi4LH3qRV6Sj2P/KzJrUZ4Rb0naAHK5/QwkMqY/q6dZ5NVFrfL1p2l
         n+kVpWZLI7i9GQXTfGjRtQPcTtdWt7KYw0HuTVFrV/SBBSwTLJfvtJoO1PBujtjrQvw+
         FcsRHYiw+eQCa8ODIrRzwNgUww7EoJxx7bvD7upax7Zjkbr2sKKgk4g5GN31yKoIs6Cr
         nMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741362234; x=1741967034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Ntml2Sm/nvVtmwH68yQthsfn5zmCNmXmNrMDICic5M=;
        b=wNXukvwGPYcH6hj29ewJEbznJyDhlKXUQ4hoB4fZ83TmRjHq5n164oe1MKpIrH6BJA
         Lyhg/SOQCdUKPUATgp0BppWqr+66RPwzWWIXT5xfGM0HQdt3CUgwEOU4f9XYnLA0/dJa
         G5dxaln+Sy8hwoMTHjHZSb5NHYRvwO1H6akYO4rfCueaMG3r4hRltjF/d1NKNDwffZWt
         /T5fUnABopnATRwS/WZJSndKHCKYDJ9mgeC+WibwiprQJlQpVl8VFWuRWcvXYowsdXOm
         Svynjo2oa9aYiZ2zBQfD8It55+OfpbXmgMfXaTrWXFkY/8f0nqkqlYT1yWJZM/s1az/S
         3i4g==
X-Forwarded-Encrypted: i=1; AJvYcCUPZzFz5ikKrEUxdOib5KUtxt5H9aiEIWfVWaUS2ZvoqlSuTmhOWEdF0SFifWdkXc8nkGEXztJDllIVmC8ZpkI=@vger.kernel.org, AJvYcCWZdkyQz8NU+dQc40f0WHJdSQof0stTDIoeyYoFnGWkwI9s/3tDo1TwYWznim+cP827W1juRt0Apuwwqp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxTvGMDXXs1Jn6iVDPT2hvecitBihsbdOpOrcAKaQHpjtVN1dN
	r/eWkICicrM5NGuL/Z5k4vISi0O/BRHnqHXbN8pi26jV91wyIPaJ
X-Gm-Gg: ASbGncujfQqbb9vMuZy0TF3F4Ydj/xkQkupXpYUfJ5XfOFBjzb2d9Qd3Isd9jRZRy3w
	kTZaTW6TwPeWCJBuLb/xhNndYq74N5CLtyAIgfYZpQU/3aBCqR5K2p8FJe+ZOl37dms4yG1XUV0
	Q0fYNSJDliC7/Sbh5qYR+TubB0Tn+L/tjwuV9fbPcRw2Ot45WhapRfEnTXw19EKPFxHzHWpbkEf
	mTGA08525JlzrQy/TrwIby67EuoDJX1dW5plMiEf0BWIyAvHE2mmNVSdrSEBTj7M3t+JreWq6TA
	oEctIkIDHjyhJ1ncPsyUTmpzWMX65V29apE2ijkPlMscF9P0yN3e
X-Google-Smtp-Source: AGHT+IFyDY96a8FxgwWSCXMs3Af462cFrv4KB62caHD64k6gpbhzlCUmJwlqDHwdaGjqoLtwkXv6Og==
X-Received: by 2002:a17:903:22c8:b0:220:c813:dfd1 with SMTP id d9443c01a7336-22428ac9182mr67446895ad.36.1741362233534;
        Fri, 07 Mar 2025 07:43:53 -0800 (PST)
Received: from linuxsimoes.. ([187.120.156.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a918e5sm31290995ad.167.2025.03.07.07.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:43:53 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: aliceryhl@google.com
Cc: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
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
	joe@perches.com,
	linux-kernel@vger.kernel.org,
	lukas.bulwahn@gmail.com,
	miguel.ojeda.sandonis@gmail.com,
	ojeda@kernel.org,
	pbonzini@redhat.com,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu,
	trintaeoitogc@gmail.com,
	walmeida@microsoft.com
Subject: Re: [PATCH V7 1/2] rust: module: change author to an array
Date: Fri,  7 Mar 2025 12:43:41 -0300
Message-Id: <20250307154341.639752-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Z8rz9nrY7Yj1Z2hP@google.com>
References: <Z8rz9nrY7Yj1Z2hP@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alice Ryhl <aliceryhl@google.com> wrote:
> I believe I reviewed this on the previous version. Did you forget to
> pick up my tag, or did you change something in this patch that requires
> a re-review?
I'm sorry, I will pick up your tag and send a v8

Too, I will pick up Charalampos and Andreas tags

Thanks,
Guilherme

