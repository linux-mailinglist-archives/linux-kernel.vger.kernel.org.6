Return-Path: <linux-kernel+bounces-309620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFFC966D7C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 02:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 929F71C229CB
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 00:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05D612E4A;
	Sat, 31 Aug 2024 00:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PNA0Ye8m"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80EA12B64
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 00:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725063741; cv=none; b=WnBFKPWK/q6/fLx1JlYqMHbb8x/+dbtidbSG5HAA5v+f44AQHR+0UtsSOUPHCKmu//3pPzi5FcYcTBfbUc2jhLnf2Pf5EY9aCVipP5cHz4YEewWUPbclbnSYiEbPFw0c0HIpFR5l1uOmsgI6z1a51Lnct+JnXcWemEMWOc/ofLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725063741; c=relaxed/simple;
	bh=WULn0vJHZY84a0XV6G37V+GnrnbAaC2/965aCStJG3w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VeyxprSP+uMelJM2yuQs4XAdfA5CttVPtxwKEqztyxKmlYjfkAgndmusA0/CwZlN4IqKnRwHbXEBtHD8gnjLukKjj3XHNsOKPly9XtMWpPZyfd1Z2z+rb5LTjk/BuAKTQ/rkWTGxtFyHEe+09ObMGv7rA7V2Dh+/YBdIXQwJeO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PNA0Ye8m; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e13e682bee1so4507277276.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725063738; x=1725668538; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KhdhM0t1vwk7kZtHHUj1KWGtjH+GSHNim9efYDdRfRE=;
        b=PNA0Ye8mEmfD2/VsYRKJXUtRVo40EmGvHT0cXCV6CRRCc64FWiQdjfR9JUcQA00uka
         srAMR6TE5kL8aZiCi4OXtxpdg9Be7xcVWEF6c1yEPbZ9bcg4Xh89qJ5TRfgtB7jDj2wZ
         k1YwNIHo4P9Q4wgdPdjb82LXuWYaLzsMUSJSehKH+xVofEPL4f6KuFLlVKzvI38VkJEp
         lrpLGi696XC3ps0VjIULsN9eenzn7vXDPM87QfPku6lpudCD7Ny2MZXlk5/EfNJTT5Uj
         Jr6r6bon7sWpfGsZZNHvbUJTVLl7jmdjs67U00NPXvtpXuZYZdgK1eMtxMnO3L/BrIb2
         Dtpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725063738; x=1725668538;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KhdhM0t1vwk7kZtHHUj1KWGtjH+GSHNim9efYDdRfRE=;
        b=h/MqVQNKqQfyGg6DH2Zn+caQNIxlfzkJTtFkiktpcrlBc0xOwTBRyCF6jp1uURelne
         tXZVGpQD6iBk9hCf26k17mCY7VLI2SnxmAjrRBdLWoTdNxhFhdbIv3mgit0xHUOCCFkH
         T4lKZZofCrk03KmL8Jv3Dlbm/47KbDfOBxqD1dsRuzQsuekKhrFWL9ePWZSL2BW/xp+u
         IcJWjBQ1/o7X1e/V1cHPAQWbJE5VX1FBLOy/+fqVL5w4UiGqmDvwRhclSUDiEEUZvzoG
         KGQNDwCBWiqgFXW+ne/o3iZ7CwS/cg9E8W8b96mWM8BxJYPd7eGJjE0ljlUlnRHEODqm
         VlLg==
X-Forwarded-Encrypted: i=1; AJvYcCX1nYogm17egs5ZTBQct6T26l+gLTUhJH+c3pcbUF8svp1M5HB/pPWhXC6GZEWPuoDOafaO+rgYQkvABo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZPB6ye1rNmJszpU2s4C7HetihPAAzTv4RVsU+Xkx+dxXi/H+F
	l4cAu7j140Tsy3LvYGmSXF13STbtzQ2K3owpyL9SkympB05THWhOv+iC4v97o5YV/wr2tuya4hD
	IqA==
X-Google-Smtp-Source: AGHT+IG7nnLBCpviNd28O6HQ7s+eNjZA8s9LR1D2CSzFzVVhtmy6ol0Oc3MkTZ8jF2KpgO1Sbnaaada72SQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:31c5:0:b0:e11:6c69:72ed with SMTP id
 3f1490d57ef6-e1a7a1c0f77mr210181276.8.1725063737917; Fri, 30 Aug 2024
 17:22:17 -0700 (PDT)
Date: Fri, 30 Aug 2024 17:21:05 -0700
In-Reply-To: <20240802200853.336512-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802200853.336512-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <172506352725.338261.15942746208095638204.b4-ty@google.com>
Subject: Re: [PATCH] KVM: selftests: Remove unused kvm_memcmp_hva_gva()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 02 Aug 2024 13:08:53 -0700, Sean Christopherson wrote:
> Remove sefltests' kvm_memcmp_hva_gva(), which has literally never had a
> single user since it was introduced by commit 783e9e51266eb ("kvm:
> selftests: add API testing infrastructure").

Applied to kvm-x86 selftests, thanks!

[1/1] KVM: selftests: Remove unused kvm_memcmp_hva_gva()
      https://github.com/kvm-x86/linux/commit/ce3b90bd0a16

--
https://github.com/kvm-x86/linux/tree/next

