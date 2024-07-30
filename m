Return-Path: <linux-kernel+bounces-267753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E13941517
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB4B7B22DA4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0D61A257E;
	Tue, 30 Jul 2024 15:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="nhKe0BNr"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DFC19E7D1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722351981; cv=none; b=GNl+0P/fEGvjxJ0gNcmwq+S9bjZ3OR1H6yMrnxKznpllef9PE80n/rhQagehr5V4MlPVTXjBCZgT5yI+fR5AOwdrP24X6wP43p+BrvFYNnaJ0MllxVKXpVu3NSPCH9+8T1c4N4J5HR44FstR5xgZ5sxCK4fRPvACB+F8GJWDXbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722351981; c=relaxed/simple;
	bh=97YH4e1beC7zGSdua9/RtvmX4IuSNL96DvtRPDGb9Xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=B6a3s5Ks9xCSNOr0/EZituuHrP+t9O3mAaY/PE7cUEYZaHIQT//oTDzroGVc2hrf63YA6oUqKxtIEaNuIwRqBlBw/SNmiYtUwUTB+COnRU6DZXvthIoty7gV5ImqG1kfy8QeJ1+PQ/QfqByWiUuWkkY5VjlBe6J1V/NFYwCmJQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=nhKe0BNr; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-44feaa08040so27549791cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1722351979; x=1722956779; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=97YH4e1beC7zGSdua9/RtvmX4IuSNL96DvtRPDGb9Xk=;
        b=nhKe0BNriiuAqQdg4DCZed19k7csmmyFrIyy9Du5fsDYucAx/Zs0RbREwdWrxBZA2C
         H8SKVGjzThQgfMRLCYCR8ns1Q0cjc0mSRcLfle76WrMVU9Wqa+Ex8dXSZN3LsGIKYxXy
         9zMSuuImMccbwMOG55EfcfeBnDbkr7bBn8Di+ZU65BBdqyrC8L55ZTzXXHa7dNHy4l6D
         PMp7CQCZ4Lm14FE79+IL8Ag3kPUCZHHhnJ3hasNBnXelmjnzTOr5L6HviINbxseIU7H+
         tij5dngq2DVvUXsDf8CkUIvq4IkeWJFmDNmQ+aOQNEukWV3WtiPRjcq+6z0U2WaTQt7r
         4ZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722351979; x=1722956779;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=97YH4e1beC7zGSdua9/RtvmX4IuSNL96DvtRPDGb9Xk=;
        b=vjVPWGzJvli95PQzNxXEzHv1RzdkSewfZXz4Dfxn3WWjk989vsZy4hzlxuTR9Shmd4
         +wmk6Q0s9c9ejdqpSUC85e0TitGtfuoXSMWg9EbeC+D1yad9/UrbxFfyYSSedCmVtEG1
         FAKW42DnO+wCterdY00nGK+vJUF9BC9RrBYq9Sf6uGd9bOt9F36X2ri7i9z7AGDDJdi3
         bbtdZ86FNaUIPlluFFTlimbiN3KbuFKhKHX0MtDu245P7IFFiXefStQYKAwRcjBbalYL
         Fc3ee6IvCOLcmf9tAwBq3xlCH7M89Q6/8Rq9/Q4yzkCGJXxnK6D6uPGh3BDzu/csuA7e
         nlcw==
X-Forwarded-Encrypted: i=1; AJvYcCUCK9Zuz0oUwlcivliAlk0yDrLMhizA1N4wK+so0Y0ikYYeHm3mDcDt+F/dU4SEefhP4+BX3xqgAz8pCYxrpQHU42bc41OT986N98V8
X-Gm-Message-State: AOJu0YwPvHPSamMqAAeI7V7i09uQqPcZA3f/95vsgJTXqHuJu8+8tvhz
	EeT5ce273LSUO4X9Qk13oqZhVzkOSnDR4DN393UxyGK6sliLJa2zXdfzTlZu8LQrY7a7v4mdUtg
	D890FKMrDS5hOZKhQ1JPACUmZn+/TVEpbnA9v3g==
X-Google-Smtp-Source: AGHT+IHK1sJ3lu0I8QGVEPxoxzeTs66mIiwGm8QGrfpPXN8kDZNechYN+Ce1XBTgKkKwgKk/Hf1iCGOHj6I2RZIpa9s=
X-Received: by 2002:ac8:5a8f:0:b0:447:dc9a:1cea with SMTP id
 d75a77b69052e-45004d7b3d0mr146917551cf.13.1722351979195; Tue, 30 Jul 2024
 08:06:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730150158.832783-1-pasha.tatashin@soleen.com>
In-Reply-To: <20240730150158.832783-1-pasha.tatashin@soleen.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 30 Jul 2024 11:05:42 -0400
Message-ID: <CA+CK2bBeD5UxD2XrjFW=9UCbASWk13UrMF0g2ZzwwBQbr7+Wcw@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Kernel stack usage histogram
To: Andrew Morton <akpm@linux-foundation.org>, jpoimboe@kernel.org, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Nhat Pham <nphamcs@gmail.com>, cerasuolodomenico@gmail.com, 
	Suren Baghdasaryan <surenb@google.com>, lizhijian@fujitsu.com, 
	Matthew Wilcox <willy@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

Subject in cover-letter should be v6:

i.e: [PATCH v6 0/3] Kernel stack usage histogram

