Return-Path: <linux-kernel+bounces-285454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C4C950DA9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C8471F25EB8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDEB1A4F37;
	Tue, 13 Aug 2024 20:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R3uNeCVc"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B231A00F2
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 20:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723579797; cv=none; b=PIHigUoCtrtYbEWwCQuyqhR9EPeD1jiSfk2GpzCyfaVSeP0WCjBe9gdig93/muTAzuT7+JtyXZK0LWqgeFFLw7AKmwWU5x9VMEd6H9LT3h4nw1BoWznpGh+5mVuRIaJ0g4DDPc/fyRuZGHPoSZaayGyz2tjyBKLCSa6gdScOFzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723579797; c=relaxed/simple;
	bh=EeBG1ng3cz3ZtvrOCXa1ktZtE8soByIQHgdXDWQF5ro=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Wm6Nx1jtV7Ux6ixX90QVAsIlm7szoIkMpnyPa825QrEBCRhmns0BrR0/wCRRVkTIdGWEZ2dLMa4v6hk8pxlVNtwlRcUP4WWsNZlWvu8Byr7ou+hOjyhlOosE3b88pSUkON1Ra28dGnZkWXJvVM1XxKxmp9Y8UpMgZJSbQAy4muU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R3uNeCVc; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0be1808a36so8704904276.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 13:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723579795; x=1724184595; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ja0CQrcVyhm6nr2lBka5ZD3vrcLqZGQb8a+gf69INrM=;
        b=R3uNeCVc8mT8ZJ6F93Z+p4NTgHpDqU8MXXv87/+NTRaC/WXhJMM9uVDGqKcuzlG95I
         Ch/ROFGg/PV1nJH2K9HEzmdZyU11JHWE+SEnSrMMQkYLGRNwbcJvwc+yHU+lKemCpjh0
         eR6/t2oH4akHocP6hznMUQxXPasyUljc4bHZVTFHjNJ6xEgz8GIRZaOzhPQRCAzKUnGd
         8S4eh6QTLyHpw0R6vqA6m8VSW+iDlrUhgSPXEAwwwiGqCjZv/VG+nbWFtSnCyfMnNAks
         wbfLTWkqBlZi7AP5q7yNnPVRTjRjEEnNyp6+bAdowdmZLyDYXZqVbSe1JrZKVMEcGQUH
         DXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723579795; x=1724184595;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ja0CQrcVyhm6nr2lBka5ZD3vrcLqZGQb8a+gf69INrM=;
        b=mCmhTKxYlM7SURnCuHCq+SKUlVFoeySo5dvVSV7OS75i54DbnOJRnm0qPku+PLt3ce
         ORmUUKqcowBFCbf/0rxEIWUbUr2wgf9QkxMlF7KOcG6KyYMy5cB+NLZ8pfjySKT4u0s7
         B7TvqSmv5CnKylt2gpoS+9V+a+chz2gRwoaunKm3SAwwJq5sUJPkFuZQjNcMaJvn+i0c
         bnwSRieZW9x2ZuBdvfeonB1O8D1ERmdBmdcp2Rh+T3X7drIkllk4Kzif1PVdpNIgc+Y+
         GU7FgYmeBfNDJcSQZ8tyPbVfKG6+pWif5JpvWozCmJdmtcL10JXpTzpRccQvPUc5J4gu
         jt4g==
X-Forwarded-Encrypted: i=1; AJvYcCWE0SHRb9Jc73CKr8NyyiT/7YB833m9qMo66zeCi7W0Upjwx0RYY8KK/thyhJGm8Zgkj3ZvMRcPu5LQTlVdNgpYRCNe8FEPAujnNcF8
X-Gm-Message-State: AOJu0YzuQvvnPGt8y3CDJx4a44E7//1PzsYZGjAQjxXQvRFSkXcgGt9S
	4onI1SDuf14s3WXMuh5W3EnIBtWtalyfoNqBpAmjJML3RDfQnZuohNW9hEEfqvi0div0/UT1Ftj
	orP7lsDoUjIML+TelE7OJ+A==
X-Google-Smtp-Source: AGHT+IHlxcyI37TL07ye4Yk+UR3MqCK5t0G+5VI5AgFVkOVLTTu7k6fZnmOS0WZ1N6sLhH50ilu0Ue66Cy6RcwPlYg==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:14ce])
 (user=coltonlewis job=sendgmr) by 2002:a25:d889:0:b0:e0b:bf20:4ff8 with SMTP
 id 3f1490d57ef6-e115585cf47mr26113276.0.1723579795231; Tue, 13 Aug 2024
 13:09:55 -0700 (PDT)
Date: Tue, 13 Aug 2024 20:09:54 +0000
In-Reply-To: <ZruZjhSRqo7Zx_1r@google.com> (message from Sean Christopherson
 on Tue, 13 Aug 2024 10:36:14 -0700)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntv8049obx.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH 0/6] Extend pmu_counters_test to AMD CPUs
From: Colton Lewis <coltonlewis@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, mizhang@google.com, ljr.kernel@gmail.com, 
	jmattson@google.com, aaronlewis@google.com, pbonzini@redhat.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Sean Christopherson <seanjc@google.com> writes:

> On Tue, Aug 13, 2024, Colton Lewis wrote:
>> (I was positive I had sent this already, but I couldn't find it on the
>> mailing list to reply to and ask for reviews.)

> You did[*], it's sitting in my todo folder.  Two things.

> 1. Err on the side of caution when potentially resending, and tag  
> everything
> RESEND.  Someone seeing a RESEND version without having seen the original  
> version
> is no big deal.  But someone seeing two copies of the same patches/emails  
> can get
> quite confusing.

Sorry for jumping the gun. I couldn't find the original patches in my
email or on the (wrong) list and panicked. I will also tag RESENDs
appropriately in the future.

> 2. Something is funky in your send flow.  The original posing says 0/7 in  
> the
> cover letter, but there are only 6 patches.

Copy/paste error on my end. Before sending the first time I decided to
drop one of my patches because it wasn't useful. I copied from the cover
letter I had already written but forgot to change 7 to 6.

> [*]  
> https://lore.kernel.org/all/20240802182240.1916675-1-coltonlewis@google.com

