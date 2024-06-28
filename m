Return-Path: <linux-kernel+bounces-234674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 984C191C955
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 00:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4399E1F23E75
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 22:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C1B82494;
	Fri, 28 Jun 2024 22:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gjkBSF5P"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C814E8002A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 22:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719615364; cv=none; b=B3p5N44ctZ8tKlwp0oAQHYCaKeUaA6nDhH4jR61t42Xard36I0m6cCh8+yToU3atz0e6d2D8mfv1Ecm8KmwnG5OoXIICvhUP/2xGRd4Qk0HSzjY29yB82/tvotLgMMzhpkn/TpMRtaT39MvJNul4KeVauOrUtsn4tCebKmij5dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719615364; c=relaxed/simple;
	bh=LVM3uqkTSyhKCZpetJYUvE3Yr/mF1UV3sFe8vrzMhE8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JkGQ6pOYussO4vGX3Zc4zIZOLWHxMF5rgeFuvgY78KwEtfEpu4YufP9PoyiNBY3knCfMkvdEVaJQk+dEtwuq+L7o2iRiGQEJbdSEIXRlX3gnjfhGYshsez0usZ1DXi8B5g4Kf0Cfuti/PTnxkejhJZfhiVTSIdvq7N4h2uIRe5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gjkBSF5P; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-722b80c4680so1154412a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 15:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719615362; x=1720220162; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ttnlucE2BUFc3AsSQbZS8PZZ80YXekALgZ+NzdoS5mQ=;
        b=gjkBSF5PUGjnFbZ6f+6VucXH7n7M6wcC7/eYirkF0fwVE7/EDPR/ReulTBZpgSEcXD
         HHjmwR2f/KqfNWgpNBm1x3GUua74CQVO2oc97RhG/578xOWJmULrfZULygThwUWYsGmn
         3yWl9xS+sqqwPhv7Glvr6JusSuQTgYTeGtcbjm9i7Dl3hbKrvBJUfcgCS47kMWer3dun
         cO2rVl6YWGXdWh8VfaKaTi9Pmw9YLMOQrW8Q8ATObIvv+sjEy5qAAmWDIbOGh9g66BN1
         1ji2i6QhZaYrL+OAF0sBBp+1tEeeXnk0M15wo1EWK0LsZz8pxOtq2zgNymha3wRNRvmc
         EZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719615362; x=1720220162;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ttnlucE2BUFc3AsSQbZS8PZZ80YXekALgZ+NzdoS5mQ=;
        b=tLFFEMzuR/16Xc78B2g6jPMIwerMAo4p9N3eYv4G/X1aVzkjsRIQUS2pG9jwlYL0CW
         Z//+Oc0HX/fkwP2w8ZVmnnYwptvkbL5U8GEesWRSD6UMBAKx66mhm+zHU6EHILbBH7W/
         Y0QjY1s+E7cAs44OLY/iw4RR3Irn2yMbCd9fFtdlxlWsxlPl4Xc5eb6BjzcY0H7fPmyp
         cDntRrhUKKdemBnKXmsUxEfgC8n3zzWDwmVBArzpb4pG+iHJFosJjKZUWLclm3+BIlnk
         zcMBNvV3wKMYkUSojiOVTyP+ixcxp5L2y7gmLyBt+q6clKGZFhIVEfGp1/2Hw4eJzEPm
         hXww==
X-Forwarded-Encrypted: i=1; AJvYcCWp9FfKwKd1zsejOmA7MGcmirppFw9/fpxAbzTty7Tim6DvC6OlV0Urq0qInyGtTG05COk+yE0RqrdOdVTEgsDNyOiJWaVpuo9OfZJ2
X-Gm-Message-State: AOJu0YyT2D/M/MZTEMXbrlNrgHFg2YHtDpBwsct7XE90uYl2xfHJpc+C
	5FYXo6y61kfDjstWdLyVAWktjw1KWDJ2DndSm+9TWcwavY/xEdBRiunDsacWrPxI0sXtgDG0Ff5
	3qg==
X-Google-Smtp-Source: AGHT+IGhT9nWsTP7CsdKQU4fzRBs3sRnyPYbvYxeAui3yoao7EDlWEgc/ibfFsDaevUVjLGQihFbGVHjUFE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:3d04:0:b0:6e5:62bf:f905 with SMTP id
 41be03b00d2f7-71ace6d26f4mr47242a12.10.1719615361864; Fri, 28 Jun 2024
 15:56:01 -0700 (PDT)
Date: Fri, 28 Jun 2024 15:55:22 -0700
In-Reply-To: <20240627-bug5-v2-1-2c63f7ee6739@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240627-bug5-v2-1-2c63f7ee6739@gmail.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <171961374413.228500.7729150745631933428.b4-ty@google.com>
Subject: Re: [PATCH v2] kvm: Fix warning in__kvm_gpc_refresh
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Pei Li <peili.dev@gmail.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org, 
	syzkaller-bugs@googlegroups.com, llvm@lists.linux.dev, 
	syzbot+fd555292a1da3180fc82@syzkaller.appspotmail.com
Content-Type: text/plain; charset="utf-8"

On Thu, 27 Jun 2024 08:03:56 -0700, Pei Li wrote:
> Check for invalid hva address stored in data and return -EINVAL before
> calling into __kvm_gpc_activate().

Applied to kvm-x86 fixes, thanks!

[1/1] kvm: Fix warning in__kvm_gpc_refresh
      https://github.com/kvm-x86/linux/commit/ebbdf37ce9ab

--
https://github.com/kvm-x86/linux/tree/next

