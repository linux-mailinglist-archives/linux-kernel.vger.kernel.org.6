Return-Path: <linux-kernel+bounces-439239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D76FA9EACA8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D451188CAF6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845E6223338;
	Tue, 10 Dec 2024 09:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lPVwIVCb"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1321F1991B6
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823560; cv=none; b=gFP2cor4l+Ww8npRTrWURDMXVeWNIYmMMK+Vnd0wwQ9EOLdEmB5MhZRa2pWw4w84aZU8jA4chAst4u8l2SB4C1qqWgGr4i4IRT0lKvM9GPH9imDW5U9bpUbJ8rqxAaTq162yL45lSA8H10xtF8GmcjBgaVbu/Lg+Site2M97msY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823560; c=relaxed/simple;
	bh=ScMGOj9NvVYHIEuh2EMhPYNXIIl1JsNTzX4GNPfWpHY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=imKvTHG+iX4biNSwv2G55eBwJGdby0/DDVBnEu6BpEOQpMui6gOOeCderLUYvAacOEDlKZwoeJFZZfNL5yTdElkymN9cyqAMm8bxDC9GK447klfj1Z3IhiWAtgmgL3Qt4pvw8rXO8DyIHQ52nNmDC9NClsH8DEhaUxP5C2/Bp0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lPVwIVCb; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3862a49fbdaso1817829f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733823557; x=1734428357; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nr3PYh2OMnbrkzV3RK+j9vm2ovz3TsnwUxy3N3fNCtk=;
        b=lPVwIVCbj7Gl8mbj2kguByswIJLJQIUTs8CKcm/uVUHB3q2oT1F+FqxErkoqUQVw9C
         KUswblgXUXaUnNjitVdixvHdZIfLpizfuTJvy9kclBGYSu09pYksIPuSPuPP4G6B4TMj
         ShqB9h6AeSKDWqT+sQkHw2p1Myoilk7fU50szTCIvnB3AdnNkgreAuN4abEUZi+t/ZNw
         ZO0n6PvyX/5XUVtC6seoCjI31YDRbrHUJ/YObCh93V97vfl6w6siKW2nt50Fl/aqbdiH
         d73AnTbo5AHlK/EaAOpGceQOwpTrJCvkyrUuhv5tWkgwykzae4Dt/dXce/OwqlbfFefH
         HX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733823557; x=1734428357;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nr3PYh2OMnbrkzV3RK+j9vm2ovz3TsnwUxy3N3fNCtk=;
        b=ntKeP8wT+t9j4LVwZ6Vvu5hIrrybYhA1YnlUPlT5Rwiv92dxaH/UIowWm+jJlvWMOp
         HVTXm2xPaphV9b0ju5ALzd1hEOHD+XBgRhxLgVIdOABpdxmdrtAR97y3Cv+nPNlRMH3g
         QY3VoT/9XcUcQ3SmJYCYT3w8gwQFcsV869iE5akEf4cFRg1HUoKFeIGZBr1YSKCdhC2/
         wMGuAmqQPH2Kr5+OWeyXwgwVhW5bQifMpSLCV7c88ca490sxhN+fJVEEVR5T1FrWOpkF
         j8vlN67WVB7zkZDdYku/VpEjcL0J2upwbu+DzNrqK64VcA6hqlzviSYWOhG0z/Mw6Hc+
         d/FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTfYNj5Vzi4vq9I6bkAY/fdMlemTe6LH/0ZXrw7V627FKJGmcrcrYjdF7iUAWBNMCslEAdqEL1VZxTfPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxFHoZ2PR7zzPzCwRJ+YV5f5GVAnD+Bt6S7m3lL+tnCeiESxUB
	V/9feVvT+GZ2Ou0d0oPImJRNn20qIwiki40txBJu59utw0JOrBPd//Sih/baROhHTHLNjOA/a2T
	aOODKDcmfrhpIXw==
X-Google-Smtp-Source: AGHT+IGXgtsVDIqdlMtZuNz/BFrutSDKkP6rnHU8K1Xb049vnHZYgJbHmqCy8DfoFipuzNsVfnQ7SYuHeQM4SrU=
X-Received: from wmbjq10.prod.google.com ([2002:a05:600c:55ca:b0:434:a1af:5d39])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:64e6:0:b0:385:f220:f798 with SMTP id ffacd0b85a97d-386453d269dmr2633050f8f.6.1733823557548;
 Tue, 10 Dec 2024 01:39:17 -0800 (PST)
Date: Tue, 10 Dec 2024 09:38:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADMMWGcC/4XNQQ6DIBAF0KsY1qWBUQG76j2aLggMSqJioCFtj
 HcvumoXTTOrP/nzZiUJo8dELtVKImaffJhLqE8VMYOee6TelkyAQcOB1XTyydhSNEidH5EuOuq
 JttZJJ1sluNWk3C4RnX8e7u1e8uDTI8TX8SbzfftPzJyWsUIAdFI1il37EPoRzyZMZCczfDLdL wYoo6pGgyCxc058Mdu2vQFCgTquAgEAAA==
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1443; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=ScMGOj9NvVYHIEuh2EMhPYNXIIl1JsNTzX4GNPfWpHY=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnWAw9BGWYF8JSAVWKirAtkHDQZtG8fkgkgywr/
 OHhrEXHW92JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ1gMPQAKCRAEWL7uWMY5
 RjS3D/9sBv8qCTU7ggpOVF+ha7vEdMGhvv6FjulBTDe689GMKZvjNedkStg3f8olCn4FPrX8Vqu
 hI+SfsQB2a9+3vpDHDuLVeUZhbcBVeXSdTAIZm44kLWHNaMg8XNxjreoN/Zqh47JzhdVj/YW6Vu
 kdL3qNak6Xju0t905+DoBTPG9PDKTC+Cufxxq8jrmbt353nq47iZWZ+Kqh9sYuLIm9tkstJyjWU
 DLpNkALpqvD+Y12vmc8W2jokBni99sZgy1/XwnuvSolSZanqGmHkrLFo2ZlS/98fohMnXfZIp/8
 GNB60keTEfVQvByia5vZ6Rq05Eop3IH36qHWx8Oexgx3sON+2D//qPsGGmWI1Y96NS28pbcZJ30
 XjerSCVbbb3vC+ZqRUteOIg4BHODf/06uydw9vcKQT4Ddhp4WuRqakU/++4TwqQclYeGcBdeKVR
 rAarQJt8ka7BZX/tHWHsW63HHn1WgcgAuyg8zJSqM7rotv5GlyX51wJEuUr0Nw19Sk2ei82W5xH
 5bsiF+equ9bYom/h6AwJDZ0kVWAth1lnC3/InWn6r9EjOxlLm0Og+lWno2Ura9skZGax5oCSIfG
 S32MHAs3I7Hxqzf6DUOCvIVSI8XYHIQZgnnJ7S7MpGSwnrj3tXNE17iE97lefx+ynsQZFWk0IiU 7L79fF+7zglI5aA==
X-Mailer: b4 0.13.0
Message-ID: <20241210-miscdevice-file-param-v3-0-b2a79b666dc5@google.com>
Subject: [PATCH v3 0/3] Additional miscdevice fops parameters
From: Alice Ryhl <aliceryhl@google.com>
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Lee Jones <lee@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This could not land with the base miscdevice abstractions due to the
dependency on File.

The last two patches enable you to use the `dev_*` macros to print
messages in miscdevice drivers.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v3:
- Fix build error in fops->open() patch.
- Improve wording of some comments in fops->open() patch.
- Update commit message with more info on why `struct miscdevice` is
  only made available in fops->open() and not other hooks.
- Include Lee's device accessor patch, since it's a needed component to
  use the `dev_*` printing macros with miscdevice.
- Link to v2: https://lore.kernel.org/r/20241209-miscdevice-file-param-v2-0-83ece27e9ff6@google.com

Changes in v2:
- Access the `struct miscdevice` from fops->open().
- Link to v1: https://lore.kernel.org/r/20241203-miscdevice-file-param-v1-1-1d6622978480@google.com

---
Alice Ryhl (2):
      rust: miscdevice: access file in fops
      rust: miscdevice: access the `struct miscdevice` from fops->open()

Lee Jones (1):
      rust: miscdevice: Provide accessor to pull out miscdevice::this_device

 rust/kernel/miscdevice.rs | 66 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 55 insertions(+), 11 deletions(-)
---
base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
change-id: 20241203-miscdevice-file-param-5df7f75861da

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


