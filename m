Return-Path: <linux-kernel+bounces-566604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18936A67A63
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1578B3A7990
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9E6211A07;
	Tue, 18 Mar 2025 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LSDIQkAv"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C18320FABC
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742317655; cv=none; b=rIyQ28v3Bw/QBTU6aFCItFx0dGwGalTu440ZM9mot+2jPigJcqmhwYuyIg3oYeQ+LwVbDT1a2mnsW6hYH082DpJkmqtJ3UhphEqDwvnmlTJIjg6nqpbXjGu/4YcNLBOIU6mtwLCSUUaTc3qpDt5bU3WDk8RDqxy1bwpzjnq1aEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742317655; c=relaxed/simple;
	bh=LlLg6jwde9CUgeBq+7ayo6eExyGhvmbmW/yF4J6CMCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b8huGM8nx3gE1tncYvW16aEDkVSbrX/E/kunaDZOy1Zq5C73z2uuSwGjhTjbdW6t/GpxjLUNggjetVANNDTD14LONwyN/IaNlniZJwmdjxi5GUrOwFMa+fB99iaafxQMLauziZDnoEsxHxvH20/+bzyuEXUBOVLJyUyIa3EfGsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LSDIQkAv; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abbd96bef64so1034817166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742317652; x=1742922452; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LlLg6jwde9CUgeBq+7ayo6eExyGhvmbmW/yF4J6CMCc=;
        b=LSDIQkAvxLviRWA5DUsNaFIJFFbUQxn/gioLwGWLiz1QUP01si3YnJx5inbk94/71A
         er2NC0Le0UKbo9qSFHuypRSR35SUVuYEZULdyKebFeDskj28141E1ZH5vFKseHXYfFVE
         I8nImRcfIxYWtMkHnM/u0kMjvw1qayklTTXyUkvl4nDgd0fpkdHYiy5SK5P3c0Y2kMDo
         5sgODP0jH+RX0Oc8oaSL3FY9ksogltNpNa/6B1SV6IKBT7AD0vUOehzmk76yyd7UJCbJ
         D9lpq035SMmZ82sR6ALkqLdPWZXR0YBrrXegkFKLHUHrcev5bsNuLNCzHi0Q3SVnnx86
         u+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742317652; x=1742922452;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LlLg6jwde9CUgeBq+7ayo6eExyGhvmbmW/yF4J6CMCc=;
        b=L/xUrUn+CD1Ivhb+3haCdn2c36oHZDG+8iNEqOVQU87mc60uZxSp6RkFhdnNZKU7sy
         wJFyq18C+AwabwlTps6+Wx380IEF+MmhToGieY3NdYwE+n91BZwdPy8zhfYOR+EN0UiI
         5tBzP3wcyOpoTkmtAQI3LCvDU4pOwaV0YZmhr4uet9yfGVLJWDHoTUg3r304NJDRn8Vl
         NvyVBZvcfiBGxGeF2LzQEekhTnTK+Fqgt8ibXvxkobFj6E5RMOg7mBVnFJFBP+Wscml4
         CiyYgL4qEyKbwfHzASoZPMqmRGqW08iyTXBB2gdMYqksKL/buy+dw9hA886+e4TieDTd
         WX8A==
X-Forwarded-Encrypted: i=1; AJvYcCUQ9tvQ8XUYdd3KBzgaHixMPc7G5iDaUfbux9GO6dQcpGavk+SmuNdMwGumI85oK7sOlGZ+ClMurTdRbYY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9uaRdpL5/dBF24gPb00MTE/JjiM6WTDXzxTKGRvDq4Qd+0aEm
	6zlGEJVEzvL9f9ufyGuA1TE0zAv47Dm64D7LmsKjfmD508yrHAbJlpiqotlx2XBjYPhQDb0xV0s
	T4R2c+eUq+PQ+3gAB/+5ezB5usoI3B/fiYgXBGuP6Cu2TxtDa
X-Gm-Gg: ASbGncueMN4qdg9K1XUgtaV/xHS2jahEQZREyv4QOy/e2woY98B5PqXFCzsXgTGARJT
	alqdsrfcqeCKZ8/t9QjGn252sJaFb9B6R2dWzr3emRfm6hPg11Z+3wvt+3Rh/XOksZ7OH+gH3wN
	QM7n0iArlMoVU8/+OCnhJZycX2
X-Google-Smtp-Source: AGHT+IEow1BlcqFlv//R/FmMhI1O328lsFzXKamFqknJTFtdD0P9/1gODkLqTO2VRrWyJMhH2t2sWaT9w+Ksqb5BWSs=
X-Received: by 2002:a17:907:2d89:b0:abf:5266:6542 with SMTP id
 a640c23a62f3a-ac330489385mr1911248066b.55.1742317651722; Tue, 18 Mar 2025
 10:07:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318095440.436685-1-neelx@suse.com> <20250318154552.GE32661@twin.jikos.cz>
In-Reply-To: <20250318154552.GE32661@twin.jikos.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 18 Mar 2025 18:07:20 +0100
X-Gm-Features: AQ5f1JpWZKk3yj8wKqrNv31flLCogTgPfnG2zjF65sslmtXCPL-IDmWnGlGQUo4
Message-ID: <CAPjX3FdLp-niyvQX5vkrPtqwJcRB+hcax=0wRbKdQvJS4T+-PA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: remove EXTENT_BUFFER_IN_TREE flag
To: dsterba@suse.cz
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Mar 2025 at 16:45, David Sterba <dsterba@suse.cz> wrote:
>
> On Tue, Mar 18, 2025 at 10:54:38AM +0100, Daniel Vacek wrote:
> > This flag is set after inserting the eb to the buffer tree and cleared on
> > it's removal. But it does not bring any added value. Just kill it for good.
>
> Would be good to add the reference to commit that added the bit,
> 34b41acec1ccc0 ("Btrfs: use a bit to track if we're in the radix tree")
> and wanted to make use of it, faa2dbf004e89e ("Btrfs: add sanity tests
> for new qgroup accounting code"). And both are 10+ years old.

Right, I could have checked the history.

Though honestly from the diff of these two commits I don't see any
valid usage of this flag either. Must have been somewhere in the
context or I'm missing something.

> > Signed-off-by: Daniel Vacek <neelx@suse.com>
>
> Reviewed-by: David Sterba <dsterba@suse.com>

