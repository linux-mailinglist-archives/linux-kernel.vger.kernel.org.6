Return-Path: <linux-kernel+bounces-429911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D479E28B6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B9316682B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2351FA167;
	Tue,  3 Dec 2024 17:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHfx/oG6"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4F81F8916;
	Tue,  3 Dec 2024 17:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733245739; cv=none; b=ms/xejQw0gXCSVS9O5g95PwM6RM3FATBNBBbnflcf/A4z3IN6WLvcefddl8OKET+1iOrusyTb+2gvqXuv0rSY/SWRPuKYlvs/kqL6q7pchjOWpFrGtbqwxoDF30GH0ra3iR8N7SBMMeUwxihlFTvCO6+fSz9w8rcqKrtti47eow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733245739; c=relaxed/simple;
	bh=llubugD33UtLbMNSAYPh4S0QVhXvEcS0Bxvt3lhri88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=StRc9rCQWK2kiCmzQrDtoQMTR8vPQMz2NHDKDaEEEUzezGxXdPGjYeAzI6WLk6K1PCKgh3noyMP4QIEbXx0FZTbo/N1OCoi/tJMhDf6EvWAogpoaKU0SVWjIB1v3Em0s8guYRFzZWDA7TY8tPET672t4kJ+R+SzmGStCHCYhOAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHfx/oG6; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53df1e063d8so7545348e87.3;
        Tue, 03 Dec 2024 09:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733245735; x=1733850535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j8xdO7uSAmdeXdaXhAt2LPxaiOQvWWPfYYTgLrEVF90=;
        b=MHfx/oG6DNJkckIF057K0wtdl2uUPR77Zf836lfY7D3XpYy1qUVh8M/T6+iQG8Joxp
         TZSqUEjd4Ubu52okBmmYNJAN3M//LXGvZHTyHPnasp6ratlY5UP/UWHjJIrH0cG2RuEr
         8dbe5TYs/HJGuWzduvV80Pj4PCQxRgkr7SZbRZOqCPxQM1eIqb6pwB52q1jvt3aP4hbD
         n6gF6T80ZdJqStITt+IEp1EW9py6AYtrK4ZzL72LRG3C31jwc0G84ouXw7P4uHUc5DmT
         EXWVts2wiW20p3lLEXRFyizpCyJ6N5kxpCHV0Ru/ID/TfGGJXXgfxRh1J/SvDovJxy3n
         K0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733245735; x=1733850535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j8xdO7uSAmdeXdaXhAt2LPxaiOQvWWPfYYTgLrEVF90=;
        b=Nzbg2SE/LNdSyqAHi0LONOWx8XEwZtjW3/Ir8fXpPjgWdMQ2ooS70DTs4CNzelqK8z
         CcpTFsHgmEjmMMw6Kp4uW8Sn9PA/yz7inbLSKxJJim0Qknfdsm9ugWyt7QAYlPt6PiqA
         kpXUnYfkhYKHJJzVVuTyj0OhVpz0Laz3dkFkY4ocCMj/EMiRpEzXYYs2nWLvizyn+EWB
         GNEaGpStoudJqnjEl8AtY+i9tijQ4ufYiAZDRAUmP419jJUetRPckrQIDdj5UEHJ3y/T
         /7BGQhgkLTRjSUs8zCyLPhnOW5MmaWv4S8uHO7rjTM/inYQ5rdMkBDHzAfuZDQb4fjxj
         JScg==
X-Forwarded-Encrypted: i=1; AJvYcCUhS95TGrecG00l8AHOZp5Jah+IZPKNTTrWdGRFXITTtPH0fTRi2onS0IAGpEzWhMyWEok8sSxZ/Jl7bqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBy/JMSI/pMt78Lqti+afS/TviGWK4lPwbq4I0Gh5XjZKrvmPX
	py9b5wr34zpPVQZK5rTMxUdDxvlxAREz8g8raJp2I+jWPUnB54yZNtPk1w==
X-Gm-Gg: ASbGncv9fHNs0EJmgq8D5h3Jd0jNeH0FB3Zr6g/ulH0zNqZZ2aqQuZh4uQE4bVYGWv7
	YkwRggr/Gc/hYc7vDN+UV7HE8ajNgBfUApnoWCGS65pMb+k9N6FPM6Ws4y0jlRlR0R7UK7DA6i0
	nprZi4Qt8anXUoWKE+1rGEZ5SHJaMs4a4jDfSOF62W3LiGWKc47+4CmzZVj0ZkwAPnBWtM/1FGI
	RKqbQnikfRdP3TAsMjx8ZL+VgiTgpuvy6LBmN83Dhu3HOCDTqz567T5IAo6DtX5IgTIw+zMuyjn
	kpRU4v3WbMdBW4nPIdnH
X-Google-Smtp-Source: AGHT+IHfeCJtMPc4CL71SUxwIM/hZO9OSoFqlkV+xBr19Tu6JMY210/2r+5GNGRO/pX+NA68F7N7wg==
X-Received: by 2002:a05:6512:1589:b0:53d:e324:11c9 with SMTP id 2adb3069b0e04-53e12a39247mr2123837e87.54.1733245734836;
        Tue, 03 Dec 2024 09:08:54 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df644336fsm1893394e87.80.2024.12.03.09.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 09:08:53 -0800 (PST)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Wedson Almeida Filho <wedsonaf@google.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org (open list),
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v5 0/2] Add dma coherent allocator abstraction
Date: Tue,  3 Dec 2024 19:07:42 +0200
Message-ID: <20241203170752.1834271-1-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for a basic Rust abstraction for the dma coherent
allocator API.

Changes since v4:
- Documentation and example fixes, use Markdown formatting (Miguel Ojeda).
- Discard read()/write() helpers to remove bound on Copy and fix overhead
  (Daniel Almeida).
- Improve error-handling in the constructor block (Andreas Hindborg).
- Link to v3: https://lore.kernel.org/all/20241105104726.3111058-1-abdiel.janulgue@gmail.com/

Changes since v3:
- Reject ZST types by checking the type size in the constructor in
  addition to requiring FromBytes/AsBytes traits for the type (Alice Ryhl).

Changes since v2:
- Fixed missing header for generating the bindings.

Changes since v1:
- Fix missing info in commit log where EOVERFLOW is used.
- Restrict the dma coherent allocator to numeric types for now for valid
  behaviour (Daniel Almeida).
- Build slice dynamically.

Abdiel Janulgue (2):
  rust: error: Add EOVERFLOW
  rust: add dma coherent allocator abstraction.

 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/dma.rs              | 136 ++++++++++++++++++++++++++++++++
 rust/kernel/error.rs            |   1 +
 rust/kernel/lib.rs              |   1 +
 4 files changed, 139 insertions(+)
 create mode 100644 rust/kernel/dma.rs


base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
-- 
2.43.0


