Return-Path: <linux-kernel+bounces-220129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A0390DD03
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C29AF284621
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0223B16EB79;
	Tue, 18 Jun 2024 20:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zqkH3oIW"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1524516EB55
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718741110; cv=none; b=k+dekXSVA6fsByQCWNn0xgJuNELhwaXEoMPtHSY72HRxBlop0zsOqg7EiBlYMpf10YpsQOUakp+TopombJyxL7BM9H8W+LpGItAsDaUj2cd6F8kTULl2bP6se09DTzBr2kB23tLgT7zjZjrIfCMQs8GPrWgVi7cNIOrFHo8Jbfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718741110; c=relaxed/simple;
	bh=5Zo7VZ+Vhja+a/AGa+Enk6lkrohhqpDKU0SlFbgQMHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPHrkuZCdwpWnB0r+vgYEIc71ZbF6UBhOgP2ofE7MykjhwKgwbw8BZMg2kab9eeMu41ynHKQsh2ltxadbnjXa1N+uquB5W9df6J6lLIyOWwz5SK1d12OfPkev36HjDuTiQ4x2ON7PQF8ODUhIkYfTPonwKFy22r+UJNrjPqch0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zqkH3oIW; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7061d37dc9bso1124103b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 13:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718741108; x=1719345908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Zo7VZ+Vhja+a/AGa+Enk6lkrohhqpDKU0SlFbgQMHg=;
        b=zqkH3oIWyfM8FcjitObKXX1MQRRRNfc09yUBiVx/bXCwfUg0THLobsNAyjIyFgC9c2
         oDXicFdZRgCyhk/LBIuk4e3SAnS52GvurI2I0uvpuZl8OoH+R7vcYx1gCiYTU1Aic19M
         +1n6fsWM9ng+kdBvT3p7ceXGbOWMLSTvsx+RzORfCr+bEmFEwSd+n2vkgxrlEJ9I+Gk3
         0N1cqe/J19HJHSzBRNnQkZdSQdXTu2/wc7zKvK3BAeBLJQmxk8ZYBHt2rf6gCK+gMqps
         x6kc6KFG7TIVkzNjoLgjNSnyKLCp3EMvqOFCgEjIiRIOGNbEWaGVHkSk5VDPwgeMrSs5
         WAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718741108; x=1719345908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Zo7VZ+Vhja+a/AGa+Enk6lkrohhqpDKU0SlFbgQMHg=;
        b=TUUa56QZJbCVp/rwtcLMaqyOf54EuZoCIdbY4G+JYWzOX7iZoCl2pzJjNXawCum8qg
         y3GyLgeviw5iL7vJhXVVKlocTP4zlEKo2VSYFp1ZoFwuyuM5CJnhSdc2CmWaeddakD9B
         iPWtIw7VIvZkEKbUVIecXwi/3C0EYTkgtegebqvNdTK7YKJfwReOG6JF6WlYlqMg/DPs
         U3dkdVRH4HjVDuuQQjfmcBtAxgnhMGfGrR9p+odb293jjy7S6cy7TKRvwVd+I1YfZ47z
         mrH47f0S3rXjwJfa7pRiP7vWclvk/ROXny35MJyv3Tpa4wVFNTMko/pvK23Epx5lAjTB
         RpnA==
X-Forwarded-Encrypted: i=1; AJvYcCXeB4/15qHz0rPxr69f9JNLyRmZhibZjqR0brI5qoMyfs27f2iyANuxMElCvaR7jAn1QK0i+kguX9GvHMQNVM8lMJjYry+Ja4xtRPTh
X-Gm-Message-State: AOJu0Yz68Squtv9tLjNZB6BH5ZoUsxRArpcgtQ/RLbcpdGC+uf8gUO31
	9whk2+m7krJ+p1ctu/IPuQpTArRvqqUd43kGe/alzab5U0giKv29AEu+CbdDdQ==
X-Google-Smtp-Source: AGHT+IEV1+xu9YayDaW7sIc6gmpTE1KmhTX/Cmmf3cOV3z28LY3VjNvYROtXWPblvCN6ThxeIA+brg==
X-Received: by 2002:a17:90b:1203:b0:2c2:fad6:3fc with SMTP id 98e67ed59e1d1-2c7b5af31d8mr764813a91.11.1718741107983;
        Tue, 18 Jun 2024 13:05:07 -0700 (PDT)
Received: from google.com ([2620:0:1000:2510:5dfa:e7d1:8470:826c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c466bfb3sm11255155a91.41.2024.06.18.13.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:05:07 -0700 (PDT)
Date: Tue, 18 Jun 2024 13:05:01 -0700
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthew Maurer <mmaurer@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 00/15] Implement MODVERSIONS for Rust
Message-ID: <20240618200501.GA1611012@google.com>
References: <20240617175818.58219-17-samitolvanen@google.com>
 <CAK7LNARFScHniwRZj08j0ubzNwee2O1o6yEfhQsizG7RC3oaoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARFScHniwRZj08j0ubzNwee2O1o6yEfhQsizG7RC3oaoQ@mail.gmail.com>

Hi Masahiro,

On Wed, Jun 19, 2024 at 01:28:21AM +0900, Masahiro Yamada wrote:
> I am surprised at someone who attempts to add another variant of genksyms.

The options are rather limited if we want Rust modules that are
compatible with modversions. We either come up with a way to version
Rust symbols or we bypass version checks for them, which is basically
what Matt's earlier patch set did:

https://lore.kernel.org/rust-for-linux/20231118025748.2778044-1-mmaurer@google.com/

If there are better solutions, I would be happy to hear them.

> I am also surprised at the tool being added under the tools/ directory.

I picked this location because that's where objtool lives, and wasn't
aware that this was frowned upon. I'm fine with moving the tool
elsewhere too.

Sami

