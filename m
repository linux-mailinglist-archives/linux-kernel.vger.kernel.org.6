Return-Path: <linux-kernel+bounces-280084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA1F94C57D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 21:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB9DE28742F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816851586DB;
	Thu,  8 Aug 2024 19:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y1rWjo1M"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8C2156238
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 19:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723147121; cv=none; b=DN+B8vUutm+Z/eMbaFnBdL7Sad5jGC52KpD/PNklZI9vkWqKym1r98oGYF5Vsj8VMyX8EUnJMVaQNtQsVUvxTn/c/E6BK8N2G0fwVgndikIQ/lAff8OUfHZuC/B5aFdQQACHNfmEU3z5EIiu9AyxqyDC4fK0TZwwiu5N77bGv3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723147121; c=relaxed/simple;
	bh=qhoRELp0nXoI/COuYWXvg+4+/JGWDI6UHeZkQ4j9XoE=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=pSevUbhlKkYq5aCBPcKh1EMK4fVQMw07NKSR84Tc0njJdfWK/Po2Mg1pt9K8iX7wYEIj0LT3CdLTS8DY/Sy0lGzl7/lCxZ/LsxcnjseDyVOmys/jDz/0B9GAKHC6nGZm2tapwnd87AsN4AhOg8evPaZv9+C4ozOmVBBeO2qYl44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y1rWjo1M; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-66a2aee82a0so27869507b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 12:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723147119; x=1723751919; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qhoRELp0nXoI/COuYWXvg+4+/JGWDI6UHeZkQ4j9XoE=;
        b=Y1rWjo1MmB56vrMwCSjaOyrqRVfet7Pc55deKEta7HwhEODBRe9zQRtAqTfErA9hZX
         mlKYkDcQIVJ7G3Z1RjAExq3uWAogDjKWuSDFKxv1IVIM4YPKfqV7hy0a0Bjkp0xUWZ2K
         tkwbUg7ubYibG6WUfczAeAFQMtqW4Y3veQt/bv67kwuIr1mWqU6uGz65M8R8oFjzUWtG
         j4cK6rGue8ISJ/iwziRcevq38i2S+VIHxEpMazi85EObR5JhW4l9QmNJ4NIyaLmlXFeN
         bSDTJd4NbnMbZ4PYjwRJvPudGUWuPZn5Nrhr5BqtMQmCZDoiWmIzrNly+4e7/3qojNdT
         O78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723147119; x=1723751919;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qhoRELp0nXoI/COuYWXvg+4+/JGWDI6UHeZkQ4j9XoE=;
        b=xE+ZjuzZ9s9PUBYRURIR9UYE7Rvzp9X+tfTbTIB3V2sH9Wdqf2e6wWYwDYEhk81ozH
         9N9O6YKzgOhYHg4/MclRw7eKJLxeqJHJhHVznyqEsSCkG1ufcOMxIi88LNCMqNhbocFB
         WPQRq+ZNalOOzOxAIwagoGE/LzqGjtM+IvvFE93gSUEE3ZM0IPlakcDavOkQ5SNoKJzV
         WfhsZ2CsxbLHQ86PaWE6sfVffGIvMhIFJBUs5R2iQWkEOjKRvH28W5koW5IWXkQFyHfg
         liC0Zu8zBg1JQHoNhf4mueVQxrMtLKTegvwh5AhOA6gX5leCAQRBY2gpqRIdeQEZsdpE
         5m6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmDrkBotPZkJertwyOlanQnH7SjLAy78kzEL22cjXUEQNnorF76qows+ar7ZNGLKs1BqRziki09Mzsrj+rSyK86kNyWEkqL3v/foNP
X-Gm-Message-State: AOJu0YyNdizOg5vUSt7+16cBnbOU+dOPEmS8cI8H5knpPHbKu0yp/Hi5
	Y4doy3gNgjN1IduqAAJlZukRUgqBBHU5Ev+oCyGBjuKWNpE7VG8xdzNdBy9htNw0qzAoiVbk2aZ
	A3hV6heVh8LuK71SE90KI8w==
X-Google-Smtp-Source: AGHT+IEigNweiXDrAdz21J+YdPs1Skcc9+Ege+GZLI1vt28thJN0TK7T9V1VytHT8g9OrCSwhqlqBNlR2BBx3Tt0VQ==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:14ce])
 (user=coltonlewis job=sendgmr) by 2002:a05:690c:3082:b0:66a:764f:e57f with
 SMTP id 00721157ae682-69bfb7e34admr335247b3.7.1723147119376; Thu, 08 Aug 2024
 12:58:39 -0700 (PDT)
Date: Thu, 08 Aug 2024 19:58:38 +0000
In-Reply-To: <ZrUGpZVnUN1NaVga@linux.dev> (message from Oliver Upton on Thu, 8
 Aug 2024 17:55:49 +0000)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsnted6y23dd.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v2] KVM: arm64: Move data barrier to end of split walk
From: Colton Lewis <coltonlewis@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: kvm@vger.kernel.org, maz@kernel.org, ricarkol@google.com, 
	james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Oliver Upton <oliver.upton@linux.dev> writes:

> Hi Colton,

> On Thu, Aug 08, 2024 at 05:42:43PM +0000, Colton Lewis wrote:
>> This DSB guarantees page table updates have been made visible to the
>> hardware table walker. Moving the DSB from stage2_split_walker() to
>> after the walk is finished in kvm_pgtable_stage2_split() results in a
>> roughly 70% reduction in Clear Dirty Log Time in
>> dirty_log_perf_test (modified to use eager page splitting) when using
>> huge pages. This gain holds steady through a range of vcpus
>> used (tested 1-64) and memory used (tested 1-64GB).

> Would you have time to put together a patch for the dirty_log_perf_test
> changes you've made? This would be quite valuable for testing future
> improvements to eager page splitting.

I can do that.

>> This is safe to do because nothing else is using the page tables while
>> they are still being mapped and this is how other page table walkers
>> already function. None of them have a data barrier in the walker
>> itself because relative ordering of table PTEs to table contents comes
>> from the release semantics of stage2_make_pte().

>> Signed-off-by: Colton Lewis <coltonlewis@google.com>

> The diff itself looks good to me, so:

> Acked-by: Oliver Upton <oliver.upton@linux.dev>

> --
> Thanks,
> Oliver

