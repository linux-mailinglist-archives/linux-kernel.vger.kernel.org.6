Return-Path: <linux-kernel+bounces-435839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505ED9E7DCE
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 02:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C89B16D297
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 01:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F2217597;
	Sat,  7 Dec 2024 01:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1sTJUSh"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1466A22C6C2;
	Sat,  7 Dec 2024 01:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733536054; cv=none; b=sq/vjTSh5sGyblQ7gou5DIxPl7Kyco3hPkD9/N2EqdRHoT3ZHwGa6uO1/DWtO8x02Uz45EGbU5p/OgtKeHASVsNDsk1LOuCLp66/PK76Sw0BHABk/k9K1xqjoTpi2mZDr3zOwuBW48zd/t3FFDNk8FyjZq+PEMhaRTIonqD1OlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733536054; c=relaxed/simple;
	bh=E/P+N9rN4Hsu0eqpO0B/IqbdTsgnh0yi0Wz2LnKFW78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RdOjYykFUKA4V4ocTUP+tfsoX+JO1OH94TzYC827oxzWHpwB1ChqIyhHhP5QAns0Fxsre9r/clNviC5qjKN5thqf2t5r0uYqtssGtVoh3C2q9hUQ8a5ZuSyUGwIQXRlvZTjlDWkPgnl6vSzhK+kIWnYkAT7yUOJRGAr/ckaipOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1sTJUSh; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e56750bb0dso1966858a91.0;
        Fri, 06 Dec 2024 17:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733536052; x=1734140852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgHtr5pWGGRR+jZUfnbrT3BOVfL8KeizVzO2nNQCJN4=;
        b=I1sTJUShyo2O/705WXoIY0yVX4PBDYwJIoguLMyqJVU+TXl2HRvixRR2odO1d99N5Z
         W1Rqwux86r/jxcZ6VwkXNoaTInZWFjVXKUqN0uCP6NDJcJjcqZekD27AA/rOVy6IaxTg
         RmmYo9wRmws88KvW6IA4fpKDU7zJ9wOWUONXHqL+sO/hX8nDrsv3zF5SYwK8pNEpnS1q
         /RpkA3Vg4owJvNCqJ83lXN4oZUhlE+rXmcu/n0pIXiqEvQ4vVmTqEKCdIKmi+zhpYkFF
         9lmPadfW7R7TSwd+TzsRgi2cMEDIBtqwif03flEQ9M0CpR31j0pX8HwgwEwKQCTpmsk1
         Azeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733536052; x=1734140852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgHtr5pWGGRR+jZUfnbrT3BOVfL8KeizVzO2nNQCJN4=;
        b=rWA1aMi2wGq+iHxtQf8s6vlWaEHWjRZ/7mJ24wnzNGZefJNIRxJdGe+JotIyWs/pKq
         W0/ygmp5CwcGfi0KMxiltLIY0N93HRuNXnIEfkVMe4+LlmCqzK9YD2nihKiL4VSEbqDI
         agNjdk4BIp4D1XIYgONAOrifs/DNA+niXjL7pSPm1ScyMhZARp38rANwvlL6LUNFQDYa
         U1GSNuiaX6FuhuDzweGta13vpln47O29g7upvQhB86PWKJCPao3uswKakK3PB9Y4mIec
         ZlTBRlTJE/gpjuQjKsSj6JLhMa3e44xxAOzH8pd+ZDO/r2bpT4zehi4TdPmwUkQCOfqU
         4vpg==
X-Forwarded-Encrypted: i=1; AJvYcCXMeX7OOy7qNcki6Gb1KLcsbh/0WESbKxD1vNORqL+4GG9AlHDiYHSWdyb6edkFsaqGXMmpl1wDCKqKZe42lQQ=@vger.kernel.org, AJvYcCXQKF2r+UUuV/rU7WzwwUIzEm0KzoPENuzrUMvGxWVzRr6eZVpqDe4tfnOZ307OrskLGcoVHDa+f6NIBb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRizxtTVhkYp966qLb7cwtfmpgo+0eocIlyPiDotwL4CGUQHK5
	McGEhi/y45mI8Zi9e57rMx+OAP12GjBBFBI6PZLR3GWh1nnyCJcR
X-Gm-Gg: ASbGnct1FzR8frAHK8Btt2oDP7Rjcw/D6odH8CTTyWfSJ7jKIB8cM4K/VddNM8SBjcw
	zEWzut0dF0QMt6kMAoMv2cdNiP1GD0iS2UE5KSTz+aZV0WEroIYeHka8YxS1PWvEAuYdc0KCLBS
	7uCqbCStHFQb+b0TNtdUy1QB3MVdo/kMpcDAfOUs6yJgoXCR5rPYDb6QBNQcKSZGr4Nv+kUJJXe
	0rZh5wDkffAeQS5iQtyaubjg/BJRRnHSv5Nw6MgscPJT+G9kU1kwMqD
X-Google-Smtp-Source: AGHT+IEGHAg1ibsSlrOOu+e3pKfAzWmb36a8jTaYREBpiNfaRKIwRlM0m4BQj/fE7teEmrJlncc8Yg==
X-Received: by 2002:a17:90b:3803:b0:2ee:8e75:4aeb with SMTP id 98e67ed59e1d1-2ef6a6b84f2mr9232610a91.17.1733536052070;
        Fri, 06 Dec 2024 17:47:32 -0800 (PST)
Received: from linuxsimoes.. ([177.21.143.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eeffb6035esm5047192a91.0.2024.12.06.17.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 17:47:31 -0800 (PST)
From: guilherme giacomo simoes <trintaeoitogc@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	fujita.tomonori@gmail.com,
	gary@garyguo.net,
	linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	tahbertschinger@gmail.com,
	tmgross@umich.edu,
	trintaeoitogc@gmail.com,
	walmeida@microsoft.com,
	wcampbell1995@gmail.com
Subject: Re: [PATCH] rust: macros: add authors
Date: Fri,  6 Dec 2024 22:47:10 -0300
Message-Id: <20241207014710.447144-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANiq72neo_RtANWJu_GW5LxsR5KWxriS1L8nsXkNn7ioiaEQKQ@mail.gmail.com>
References: <CANiq72neo_RtANWJu_GW5LxsR5KWxriS1L8nsXkNn7ioiaEQKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrotes:
> I understand what you mean, but changing a few existing lines here and
> there is fine. There aren't that many modules out there. If we are
> going to change this, then the best time is now. Backporting should
> not be too bad either.
Yeah, in the truth, don't have file a lot for changes.

> Sorry, I am not sure I understand what you mean. Yes, the idea of this
> option is to repeat one line per author, but that is not a big deal: C
> modules do that already.
I understand that in the C side is already this way, but maybe we have a better
way for make this.

I'm think about this, and for me, the less the developer need a think about
"what field I need use in this problem" is better. This is not because is really
difficult think about "I need use author or authors", but if we can avoid, I
think that is better. 

Well .. that said, after your tips, I change my mind and how we don't have file
a lot for change the type authors, maybe the better way is a unique field
called "authors" and this should ever be array. 

If my module have a unique author, so `authors: ["author"]`, if the module have
two or more authors, so `authors: ["author_1", "author_2", "author_n"]`. With
this way, the module developers just have a one way to declare the author of
module. Don't have different fields, don't have different types. Have a only
one way for declare the authors of module.  

Thoughts? 
You think that we need open a chat in zulipchat for this, and collect more
opinions?

