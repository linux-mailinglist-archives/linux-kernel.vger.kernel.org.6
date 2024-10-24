Return-Path: <linux-kernel+bounces-380760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D73A9AF5A6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 01:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70D761C217D6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 23:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA154218D61;
	Thu, 24 Oct 2024 23:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="icxf1yBL"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B3B1C0DFD
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 23:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729810920; cv=none; b=MwWcwEEL7cblu1IN4gBlIxDpwp3j39aXq1Qi3bV0un/Mf7GtzVgcwoA8Zqyr55Iq47V1t8RA0VY87VENENsvuRNNnqPS4KRlmwjmlgu3yGJP//D01Qq/WSKyyd2FgRkk1R4WbZdsIWdwb6Lpx7up0gRXdOymOjuTvF+q5/z1SU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729810920; c=relaxed/simple;
	bh=ybEBU/t/SJePZebl4iAjsIn1gGCyVGhTKSar4dgvytE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6fNYcKlyjLI7ezHtcnAi+rtKdzWgpmHv9WlW979aeq2ULVB/FPohkpGGlZwfK0ezpF/a9EPkLIwyRa0nsytEVw9IgtpGmsgAZuR4ujXYPj7MF7Xd7BleZQgkgggJF5V0KXbAiXk4vJqICHMEPyOR52wge7I3Z4fidii2Q362yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=icxf1yBL; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20ca4877690so35325ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 16:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729810918; x=1730415718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YWPqFC2idLXwWLVGXP8sgBtLusvgfrCXLHA1CgLV1iw=;
        b=icxf1yBLDguit0cVY9iCBraP7Qp4FL43FqAT2G6joQoC3FaY3fqe1Bg4Hl4HfK66JN
         95OmZuWqsKEGnpSs498al2+y9zlbrJEdF4F4BnYfApcpL/KLgzfQ09dAqjfao7WmGCa0
         I9Dh5GzkFvfAkKl97y9oebePwuig4qgYWd8l3RH1e5GPGUI++nF5ST7LSfPpWMuN2CPd
         O0+NCBGZRDYPItqTZDF6/IxK7tEBaRvRCtJVaSIniqgcKTi+voqu/3K9bhR6x2RmxbRe
         mYSp3OTJmd8drOIaQc5Hk8iNdAkYagVKV0it1iXsblzyxlLwVI9Xz3eX7PlaoGmsMp7e
         wT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729810918; x=1730415718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWPqFC2idLXwWLVGXP8sgBtLusvgfrCXLHA1CgLV1iw=;
        b=Q57PGA9zbdL+YpNH8BaPJt4tbR/2F3VfK8Ur0bt7Qm0EZT9hCiUy1K+CdlEvC38Wet
         Og9hrynkBaFAc+Cuok9Ma/N0dglRVs28ugzLc56+lbP4/lRW1VXsqeSKcSnqdNB0BhpP
         fBwu5zG0jbd6mWHv0JDqVTG8XJyF76/P/xRrQiG+Pj51XXdJeNRxKDJZFpilIsnSO1v9
         czbqj3RD6KMLrLg143xov3sh3b9I7iuSeZZX6mlcMTffqtL0JfcOy8rhEtRA53QzPauC
         5OO8p39gmxKxtMdHh0PEylPCh7dnhNlcp+qdX3xIlYO0cVXsSyxSMOxRLPZWANGCkSnV
         6HJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmpIfeZVZSj7VlprQ+wVsvydZZI3asQLJiQvzShDXTfeS1Volm1z6HPrfkQVDtrDgJqpP1Z2ODsAo+3NA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmSY/SeWItTiY0R8aZk4v1tiBc+FsNXxOYptTBb0ReuS/FSM+1
	ywg6s14gDTfvSk1TpgnW5Em6MSagJVCWBJFSXFsgeLNnOf2i1BXdqlY2Un4BmQ==
X-Google-Smtp-Source: AGHT+IECEzj2j2R3HEQNqRkKqGUxd9Vcb7D0j4G32E56QFP5qsmcyNWJW/GLTUqkmxlzQwTttNdiEQ==
X-Received: by 2002:a17:902:cec8:b0:20c:a8cf:fa27 with SMTP id d9443c01a7336-20fc2219a8dmr1193475ad.18.1729810917420;
        Thu, 24 Oct 2024 16:01:57 -0700 (PDT)
Received: from google.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e3572efbsm26644a91.22.2024.10.24.16.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 16:01:56 -0700 (PDT)
Date: Thu, 24 Oct 2024 23:01:52 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Matthew Maurer <mmaurer@google.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v7 2/3] modpost: Produce extended MODVERSIONS information
Message-ID: <20241024230152.GB1382412@google.com>
References: <20241023-extended-modversions-v7-0-339787b43373@google.com>
 <20241023-extended-modversions-v7-2-339787b43373@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023-extended-modversions-v7-2-339787b43373@google.com>

On Wed, Oct 23, 2024 at 02:31:29AM +0000, Matthew Maurer wrote:
> Generate both the existing modversions format and the new extended one
> when running modpost. Presence of this metadata in the final .ko is
> guarded by CONFIG_EXTENDED_MODVERSIONS.
> 
> We no longer generate an error on long symbols in modpost if
> CONFIG_EXTENDED_MODVERSIONS is set, as they can now be appropriately
> encoded in the extended section. These symbols will be skipped in the
> previous encoding. An error will still be generated if
> CONFIG_EXTENDED_MODVERSIONS is not set.
> 
> Signed-off-by: Matthew Maurer <mmaurer@google.com>

Thanks for fixing this, LGTM.

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami

