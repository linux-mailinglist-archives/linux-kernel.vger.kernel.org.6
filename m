Return-Path: <linux-kernel+bounces-197890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCB88D7069
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 16:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CE42B222DE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 14:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0822315253B;
	Sat,  1 Jun 2024 14:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEulPdEp"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AB6152531
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 14:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717250981; cv=none; b=d6io5fnjIvE7Ip4Pw4Go2GmABmXPzHu0mSwvdedbbX7wuh6FyQlwy0iSRiSY6uqjH5nygeGK8CnzykpwribLZg2N3rsOgGgK0NjNntLnY5QLMhbMc6VFZ9eUjny8Klr3860/YID1P1ynO0pTQ3yvqS5oVR/Pr9A/aqt+N9Rcuos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717250981; c=relaxed/simple;
	bh=NeTRSu6+PVl0/7CNPkS7f6S2msS+Cn+G1loShWvSDbM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iL8mLSfKDsJsgVXqLkc7o7ys2vt4c7pZKWGk8ojnGaiHJHiIJpOqwPLD7MwTJc3r7ItCZEX2uQZYwbe3KFeF6eoXENpRz6b0tuDtSPgOhqbnkrBUsVIawlUk1kxDHBigPE8RCxoJOXsHZ58QptOfTmY23z1Tu1ml3nhsGhXejik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEulPdEp; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f47f07acd3so26272555ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 07:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717250979; x=1717855779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NeTRSu6+PVl0/7CNPkS7f6S2msS+Cn+G1loShWvSDbM=;
        b=bEulPdEp/MZBByIeE99WymQgMyeF6N2czBY4eHL29kq/iqQB2hDuy2kaEXCbB3Huc0
         3TU8ZqM+sVc/V3+raAcsRXoLjZimew6islo4fWJDPlBOnge3WlSPMr92ZijMNZgAloTZ
         PeFjDidTZUiPe0MT1Pa0/J5w3Mp87L5s6VoNY21tgw9p3fIb6ibW7loJs2un8b8Q0GLw
         VIYRhtvT19QbbUXFWluRSW/Zw4St45MaVS0nGrbqAwpcYLYJq6Lkk3qS8YpYS0uolqAi
         NxvZBDREx9AXvYYmmCFgYNyXEpPkseXieGPQB9XBlwd0NB4B1fy5QiMdzFOY8nVjCmsJ
         z1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717250979; x=1717855779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NeTRSu6+PVl0/7CNPkS7f6S2msS+Cn+G1loShWvSDbM=;
        b=hQ4rZNR10ymWcirEm2TWQ/whc9RA6Ijdl9vbYR/10zdlKOJfs0f0Y0E0xORAD2isOM
         SXzLUkcYm/Wfos+6XezUPGCAUB9NsJk1voCqBaPTGmSDZ+iHf0ddcE5VxwVW5ewD+1G8
         8Bf/8wg9lt+d0uC+Q4DxpVBy9i+shXaJ7DxLTPaBJxx8U85q9/dLFhwN1tOyF4VhIw3v
         kwM/U52JcUae7SSVJ5gcSpyD1ff1m+zlX1kdnBYfvleutl33arhf5uCtLLbF2k0+pFdF
         TPXLkrx5+d5H3zD7XYHdtj2E5XwcKL3yN5WB8uAMWDf9XnFzTrhDJUdZL5ubY9srhZaN
         ixgA==
X-Gm-Message-State: AOJu0YwdyqCPMNn+yUUWvnCtdRCj3nnYAf5sXbb1btsFF0yTp6g2qoIm
	Wlgddw4bM2J68V/LWrcos7VUFLitrO2obTEGgzyh8IqyBD2S2/4ouuDYkIBt
X-Google-Smtp-Source: AGHT+IHoXMswpDOWGSy+4K1bobmhUaYAqM21uBUd6ThnxUMFjUo3ZLjid3d/YNdVvRCSx33hRGnjvw==
X-Received: by 2002:a17:902:d548:b0:1f4:a6cb:db3d with SMTP id d9443c01a7336-1f6370cebbamr56641815ad.44.1717250979177;
        Sat, 01 Jun 2024 07:09:39 -0700 (PDT)
Received: from LancedeMBP.lan.lan ([2403:2c80:6::3037])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dd7fasm33091795ad.125.2024.06.01.07.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 07:09:38 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: david@redhat.com,
	akpm@linux-foundation.org,
	yjnworkstation@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	willy@infradead.org,
	00107082@163.com,
	libang.li@antgroup.com,
	Lance Yang <ioworker0@gmail.com>
Subject: Re: [PATCH] mm: init_mlocked_on_free_v3
Date: Sat,  1 Jun 2024 22:09:17 +0800
Message-Id: <20240601140917.43562-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <8118eabf-de9c-41a7-9892-3a1a5bd2071c@redhat.com>
References: <8118eabf-de9c-41a7-9892-3a1a5bd2071c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Completely agree with David's point[1]. I'm also not convinced that this is the
right approach :)

It seems like this patch won't handle all cases, as David mentioned[1] before.
folio_remove_rmap_ptes() will immediately munlock a large folio (as large folios
are not allowed to be batch-added to the LRU list) via munlock_vma_folio() when
it is fully unmapped, so this patch does not work in this case. Even worse, if
we encounter a COW mlocked folio, we would run into trouble (data corruption).

Hi Andrew, I just noticed that this patch has become part of v6.10-rc1, but it
has not been acked/reviewed yet. Is there any chance to revert it?

[1] https://lore.kernel.org/linux-mm/8118eabf-de9c-41a7-9892-3a1a5bd2071c@redhat.com/
[2] https://lore.kernel.org/linux-mm/20240517192239.9285edd85f8ef893bb508a61@linux-foundation.org/

Thanks,
Lance

