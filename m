Return-Path: <linux-kernel+bounces-527229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04103A408B2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 14:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBDDB19C5E74
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 13:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89047081A;
	Sat, 22 Feb 2025 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msh3/Sn1"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6AA10E4;
	Sat, 22 Feb 2025 13:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740231057; cv=none; b=sRcAK7JOqMLj1eZ0MRjfMhmZVf7dXR6JI3E+9ofg4Pzfo3EVQ/dnuaVsirtRwBn2M+BTCGTaa9SV5k27Uwpf5MWZRZ1g6Gzewus2Q/jSdxysSfHIPIqCX2i9psetZBIP/rgPGjg15YFvyHYJEA7ZqjS8T/uq4pC2l/zFsB5S/ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740231057; c=relaxed/simple;
	bh=qVwkWQrnc4RfSv99Z9GdvkC+lVtOV3oanEN68KieaUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oMRZuhN15yWDZZM21+1XD629dnZTf+AdKpwNQHvmdqXLh3tGMC1Xe49g8mIzB7Vea7LGzKUlzHKfhdFlnWYD9mK5aLhopfMfcwYEts7Dp0ShDCiBA8N5LITBiCFu4lklfc4bSBdgIzxGKbhRHFFvzUhnusc+uIN6R11mocUmON4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msh3/Sn1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220d28c215eso46739885ad.1;
        Sat, 22 Feb 2025 05:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740231055; x=1740835855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVwkWQrnc4RfSv99Z9GdvkC+lVtOV3oanEN68KieaUc=;
        b=msh3/Sn1wMvij6K5ARLqfhi6mgcwraU4og7YsULUSkCaxYlknRuq6J6pQfhQ4VIGzW
         /NBymebBX+h/GcAdl92VTDrXvlUDWr+Ol+uPwqVW/b9fMbSN515JlHeo8nthCxUlzaPm
         Qg1btgCIVO7Clbry9pDAtwZZ2i/ol7YS9OWvcBhvsZEoh9o839Es0rwH7PQ1grAaGHIa
         SPl+pRX2tr8f/5LURzoiVRu+9PugYFPyypURIpr1K9MHGG89rCUx2nr1obVaMSFhIUTO
         5OsNrZET8RTRB8UaL5Hkm7ispfbpapjeEbNl+zCXtYK8eaVXPbXaQX8FbIOfe9q6Wpyh
         Q/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740231055; x=1740835855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVwkWQrnc4RfSv99Z9GdvkC+lVtOV3oanEN68KieaUc=;
        b=wukhzEL6PWUGeZAXg4OLOUKhD09FDhARF34Mj4bOyP/qPJV9VOsUtQpyPCkiXrEPR0
         aH8g6lh1A2BqZFR53RRWC5sEMuwy34G+OcqY1ommKEKZ63rwYqT8Tb04W1KFDvlB0ekp
         GwUfnn5PASuUpk+5IQvE1xven0cKDijGMiyfKLzGAaAwiuealby/Octi3j82lXli4bRO
         B5nB2h6hu0eLXiP83/8zrFCFogsxHAUGhIpFi1cW4wJQiATw85ZIZl0UnO8M01soStC2
         53bWLy4E7blpVjJcp0lo8zRiPR2eAYjsXuX78Ety5J4DrGYJNTxdt0csPCj+xFBM/5AI
         IquA==
X-Forwarded-Encrypted: i=1; AJvYcCVDHXJcf6YxDd73FXwyNuHkn1EoqCcYhXAXXhELEvfWoF/DHRFJNpv8WKqpELZdVHv4DUwqLHZCtCoxbdEouxo=@vger.kernel.org, AJvYcCVkOfScrJgIl5rfXCMgMmfqQTm0J24r7RTOcbnlS+IFe4fRDFdYnRRGwho5oQ9crldA7S5uM7YEAVXx4lM=@vger.kernel.org
X-Gm-Message-State: AOJu0YykbbbkGqhO+8EiVRlU5ulbhuTZ943iKUO0cpEO3ZKb/jT7yVgI
	ipaRZcXvrNM3ugGmKnVnqdjUKP/nO171YjcbqnKjFA0IbnRi/mUA
X-Gm-Gg: ASbGncvZiB+1s0ffW+ONAg0YbdyLXJXyuy5M4+pEfGB3XVwcC5u0/WMaf9/cFkPyZty
	0Ca+yCJY4PQIhHJsw6CnFyElabIRBxzQudu7+4w8iSeCXfe2WSpn8m7UReRiS2DlGlO+0XUXXIl
	HluSEKCWyknAnSdXB6XZizcxwFK/tt8xds4VWOSlgjlW0ZhE8Rq8cH/v+Xt0TFWHItas2nLe78V
	M6ED2pw4URIqed4h5tEDSarhJie7mBXLsXs3m4cwv+rdfg0qny6Re3rIH78XCmf6wYfXUKU7nBI
	/7KHSxOQtQQ2rL15WnqnoXIVXMxBM/I6/Q==
X-Google-Smtp-Source: AGHT+IH1WkKIqcJbrqWygAXxhVdvJ56E5Yt2n51iO0Vp+5fjNIVkve9v3zLJF+kbOXOhcoML4uQJGA==
X-Received: by 2002:a17:902:ce84:b0:21f:6a36:7bf3 with SMTP id d9443c01a7336-2219ff56334mr138798345ad.12.1740231055039;
        Sat, 22 Feb 2025 05:30:55 -0800 (PST)
Received: from linuxsimoes.. ([177.21.141.136])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d021sm153885215ad.157.2025.02.22.05.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 05:30:54 -0800 (PST)
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
Subject: Re: [PATCH V4 2/2] checkpatch: throw error for malformed arrays
Date: Sat, 22 Feb 2025 10:30:44 -0300
Message-Id: <20250222133044.56698-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b150157b266b0aa78e26b1feb5a6b3d7735a2293.camel@perches.com>
References: <b150157b266b0aa78e26b1feb5a6b3d7735a2293.camel@perches.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Joe Perches <joe@perches.com> wrote:
> check if what kind of array otherwise this comment is very poor.
> Arrays commonly have more than one value assigned on a single line like
yes, you is right, I will send a v5

> The initial "\s*.*" portion of this regex isn't necessary
> and can be removed
I will make a test without "\s*.*" and working I will send this change in a v5

> As I wrote in an earlier submission, please align to open parenthesis
> and use the common form for the message with $herevet
Okay, this will be changed.

Thanks,
Guilherme

