Return-Path: <linux-kernel+bounces-532337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8AFA44BCD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C5467A82BD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC7C3D984;
	Tue, 25 Feb 2025 19:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="txqiz46R"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1871D1DC9BB
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 19:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740512990; cv=none; b=vDSsOVP10Em0Z/nQknKYcyOOs2wLgvuI8OIwYsAlLAKJ5x8JlxPTxvb/+mQpFrR5V8BKUqYTMEb77OwuzaN9voQunuFfp0ms9EqwODXRadNfA7KOzvF4L2OirtGRpiILohkM/moj2VTQTFQofal+iCjKXYPTpyQDLGQdY23ZMSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740512990; c=relaxed/simple;
	bh=Tj5s8TjtZq4v/wFdAqOuakzk8t7y1AdtBQyAr6aL/qA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3hhdB9E1cdTBq+8HqPRKXfZhq4U6v+sSrGm9023/xmgFAnGzMIfM+ZXEReVcNE3HnzO7LE6IlTpxRxlmk444mNlhK4lKs9uTCbMSGozTsjM+vJDBlIyGOtdVL6HpY6qhmAD6xaAMD0w6L616f3EuQQvxOw1SsEI6FFLOLHR7ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=txqiz46R; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaeec07b705so1003348966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740512987; x=1741117787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wZ6WGIl+AUHgbUP8huP5qzCstVAL4wh1yB31nQNV5A4=;
        b=txqiz46Rw4wOpHZuRSkVt/Uy2jDHFbWEvAqlzDIzsuyX678C5SnyH0hejSpZGD/o80
         vJUEZ1f9eGH9sgPT7TuN/WT2u5L28dOhlfRk2ZHU7/09WMNsbbz9LtqEnJQ5AWnFtNO1
         bPGZuMbAg/Zp8YIftP408i3nMGNAN0YDHmRJUJaIXd5aCXzUk3s63s9eXZs3JwN3lNjE
         Lvvq+5smQ0csAga6qwNNLJSjtKwY4sapt5snHknCS0sJkTAbZPLxN0P2OIO3MJ1Tmr4m
         3rqOtbtKpiYXFS3uKssTV0DFW4a15RPEAH3dpYFhF3PJhvfkXQajnT3lBDEhgTu4oxIQ
         9AYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740512987; x=1741117787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZ6WGIl+AUHgbUP8huP5qzCstVAL4wh1yB31nQNV5A4=;
        b=IXyTEH+wo9ta6iU0XhS9eTxf3y8rpP0Rrj/Nsr/vhs9wyfm93NeMVHxiGkHj0izNG+
         5uN3iyhKfolAx1K7cCreZ0yLcLhTKG4DvrqWQvrLtPfLPedI15Vu7GMKuGLkRkZkUTaT
         gsdHRh/FaSU0fkbF3Pj5sq2HbK96ZnSo/D7CD0NdPaDatdTa5V0CQvlT4YOewut9x3+A
         WOWddlndpkxC+Vga6q5YHrakbIKXE1wDgz2zKJxyPX9WX4a3ecSyG77EzXvwD53/uVHT
         v3wR8fQPJX01pplZDZSYajXdOHOgkRUj8w7JkH4j7ZTcWDYlU6qDWYIUfbcrLhgaaQYh
         EHRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEQSRcrchF1W/MkjqkFPuuisBRvPD2m01SOR3Lkck/vXRMXKJOT5Wi1imn92+bu9vq9zzJ57g4VSwPmO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIEt+G7jsjoAHJUBUZokJS2ksx0Q+u2e6QhknM8RGH2N9LKTww
	IMtJPd4Bdr6xTlcVgOCctl+TPY3PEBwxeiidm3+WWk/dY5Xt+XEcR/Lapx4LFg==
X-Gm-Gg: ASbGncspGkbo39nSppDc12CNB1ntxMxYtaPKfxesBTSmXGTEwRMTA2rUBECPqA2NAXr
	ppP30ehqCwN0QepOIZdHF94T8NexPiRJfNXg2ndQi8pOm2YqAbWdiz2FPyhA1MOtuHqN1VvsvhL
	cTQDgXEGK9CYEoWlmYEebgOVcBbliS+HRbiZiADzbQk1C9SGHAgpLExl//FNJGqJlJJJpxZDOsy
	lbjyVv7LQI2CwVmDchxv18Bw8E3rzg82TjPtmNDlzJM3q32ZIxAxIkzQMJK2SWY3Dr7TcTi0pWe
	65SHmqFun806UBis9TAH0SyPHO70h342Vv504gTdBsR3BaJwCk/v4NYLIvVl6Co=
X-Google-Smtp-Source: AGHT+IE77LDENhumCNSGLklTSxZoktkRQ6fz4LwYMz58A+ZoJ1Oh18Qlz1D99LVTBsuhgIMY2PKmoA==
X-Received: by 2002:a17:906:6a22:b0:ab7:eda3:3612 with SMTP id a640c23a62f3a-abc0de4e63fmr2092625666b.50.1740512987199;
        Tue, 25 Feb 2025 11:49:47 -0800 (PST)
Received: from google.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed205c7efsm193351766b.149.2025.02.25.11.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 11:49:46 -0800 (PST)
Date: Tue, 25 Feb 2025 19:49:43 +0000
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] KVM: arm64: Don't WARN from
 __pkvm_host_share_guest()
Message-ID: <Z74e17vBiJAgViHQ@google.com>
References: <20250225015327.3708420-1-qperret@google.com>
 <20250225015327.3708420-3-qperret@google.com>
 <87jz9d299h.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jz9d299h.wl-maz@kernel.org>

On Tuesday 25 Feb 2025 at 18:02:02 (+0000), Marc Zyngier wrote:
> On Tue, 25 Feb 2025 01:53:25 +0000,
> Quentin Perret <qperret@google.com> wrote:
> > 
> > We currently WARN() if the host attempts to share a page that is not in
> > an acceptable state with a guest. This isn't strictly necessary and
> > makes testing much harder, so drop the WARN and fix the error code.
> 
> Are you really fixing the error code? You still seem to return a
> -EPERM. I guess this was never reachable thanks to WARN() being a
> panic with pKVM?

Exactly, this is really poor wording in the commit message. 'Fix the
error code' in this case was intended to mean 'make sure to return the
error code properly instead outright crashing the device'.

Happy to send out a v3 with a better commit message.

Thanks!
Quentin

