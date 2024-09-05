Return-Path: <linux-kernel+bounces-316201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F26B996CC87
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 04:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8214B1F263F4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 02:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019DD84D34;
	Thu,  5 Sep 2024 02:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bdEuC+bf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D1C2107
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 02:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725502779; cv=none; b=mMuLjXd+g0QH40T2aLlCJXdjiCA/KWexfpRXOY5udlxA2ckP0VRrb1sTgsQrzvymtwOoU9BoZw1gzEz0ftnb/kH9KENUIH+SNJIF+FmO7sVSH8TyFymLHJK5SjayglBZesE4j6pUKk0r9DMgbn4iNNG1ZUJGXFp0JAz3KnVO3+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725502779; c=relaxed/simple;
	bh=b+T73L+tj+3Z7fE8SEEquxnXMNFolcHTPEGwqPx1iEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nAwCOKljEXCBd8iCawE+ft/YNJVZIVBdwu4Wt19SDYKdm2eCprfPCBXqs42RQNyz3mBJS6VAg0kErKBUVme/3YJsfimVXUpqk0XDVadwB4nRQGXi6bQGO2KQ7vLfGnehhjNmt2BUVR1YOLei0kxYz4+r+8fm/6oQqPjKCeP4SE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bdEuC+bf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725502776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EUF/NBcLA8q8t9cAM4xsQXEfKKe9p1yR3ynq7HjYVB4=;
	b=bdEuC+bfMj42HBeZ3YL5ebFP5WAIOhkQ+k6tn0Ii61Cx7z0t25n/3PQs73fV6guA+o5dhk
	Hppu7XgkaEY7v6d/bHRX6awnhQep1XPXMxIydCqKyyPUX75wqPjR6yPZPvy/c/EH601Daa
	iVVpjWWpQnN5hRF5MRXl/sGYLW456MM=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-XQUfREuTPtKOsTD9fJNSlg-1; Wed, 04 Sep 2024 22:19:35 -0400
X-MC-Unique: XQUfREuTPtKOsTD9fJNSlg-1
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e1d1a1e4896so659021276.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 19:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725502775; x=1726107575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EUF/NBcLA8q8t9cAM4xsQXEfKKe9p1yR3ynq7HjYVB4=;
        b=K1ukPOEHoUbyMaBfQYAjxwR0wE8pXYJXLvZbeXmbT1GOUu/1Vt35nmDOlHlTx2uDPM
         pgImpP1dMgrZbVdREg/cUXwX4xMF66avrPcQkwehjrAbePiSDNjzovxDbEVxtsUhOKs2
         x2zbqjAqWvLy7Ad/7CXpsx303WyS6y0JpCHhj5ok41/2b2OgIIVleT4Idrl97GZLtama
         rTdSEU4K5/PhSieZgKRcVvRFHaiLvNZe3FlSBKobnmKk9ZpSFSOid5q4/SC/djLoPlSX
         mBV5lRcsHviYyW42gS1Sgjs3ZLhWgUWwArdSENSGjAoSHYd9bDw3Ny13EzYnIvmSnOD3
         fOnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhHpvzG8heEg2j7J514zLSw0ccLBl5Bc+ULVB/btHHjCQvLiXtOCt6tD43xWcw2lQtnrdwD9TmUq2kqf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSIbyOFHtPMMt4VDsIJfwqVYi6oeKZTwzqNtI4CaPzmialnW67
	OCHv31rWQeR0B5LqrQbHqu3iQcWR/7kaIRlNCfl0bmKbbpxHn9ovn1tEI7HnAasNB4C4GBkJI+z
	U9/QRAJYZ2YiQPF2jHaJIVxGFLlrhBiRGtymFyrHMxAjurgtcorQHVghJuXXqAw==
X-Received: by 2002:a05:6902:178c:b0:e13:d32f:b0b9 with SMTP id 3f1490d57ef6-e1a7a1c8502mr21137527276.47.1725502774947;
        Wed, 04 Sep 2024 19:19:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSZf/dVwMJ8dlS8WJRTQcc0mc/swRBAzIWDCysLiNBsT4XwBG0ZTuLADHdZ9+HD7IpmNM8Ow==
X-Received: by 2002:a05:6902:178c:b0:e13:d32f:b0b9 with SMTP id 3f1490d57ef6-e1a7a1c8502mr21137513276.47.1725502774594;
        Wed, 04 Sep 2024 19:19:34 -0700 (PDT)
Received: from rhfedora.redhat.com ([71.217.47.229])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801db22b5sm3531181cf.72.2024.09.04.19.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 19:19:34 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-pm@vger.kernel.org,
	Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Arnaldo Melo <acme@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH v3 0/4] Add SWIG Bindings to libcpupower
Date: Wed,  4 Sep 2024 22:19:07 -0400
Message-ID: <20240905021916.15938-1-jwyatt@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SWIG is a tool packaged in Fedora and other distros that can generate
bindings from C and C++ code for several languages including Python,
Perl, and Go. Providing bindings for scripting languages is a common feature
to make use of libraries more accessible to more users and programs. My team
specifically wants to expand the features of rteval. rteval is a Python program
used to measure real time performance. We wanted to test the effect of enabling
some levels of idle-stat to see how it affects latency, and didn't want to
reinvent the wheel. Since SWIG requires the .o files created by libcpupower at
compilation it makes sense to include this in the cpupower directory so that
others can make use of them.

The V3 of this patchset includes:
* renaming header messages as requested and adding people to Cc as
requested
* moving the stub (dummy) commit to the front of the patchset
* small punctuation fixes

The V2 of this patchset includes:
* the full definition of libcpupower headers that is needed for the bindings
* dummy implementation in C of a function listed in the header of libcpupower
(requested by Shuah Khan)
* test_raw_pylibcpupower.py demonstrates an example of using the bindings
* adding myself and John Kacur to the cpupower section of the maintainers file
(requested by Shuah Khan)
* addressed review comments about doc, makefile, and maintainers file
* small style and other fixes

The name raw_pylibcpupower is used because a wrapper `pylibcpupower` may be
needed to make the bindings more 'pythonic' in the future. The bindings folder
is used because Go or Perl bindings may be useful for other users in the
future.

Note that while SWIG itself is GPL v3+ licensed; the resulting output, the
bindings code, has the same license as the .o files used to generate the
bindings (GPL v2 only). Please see
https://swig.org/legal.html
and
https://lore.kernel.org/linux-pm/Zqv9BOjxLAgyNP5B@hatbackup/#t
for more details on the license.

Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat

John B. Wyatt IV (4):
  pm:cpupower: Add missing powercap_set_enabled() stub function
  pm:cpupower: Add SWIG bindings files for libcpupower
  pm:cpupower: Include test_raw_pylibcpupower.py
  MAINTAINERS: Add Maintainers for SWIG Python bindings

 MAINTAINERS                                   |   3 +
 .../power/cpupower/bindings/python/.gitignore |   8 +
 tools/power/cpupower/bindings/python/Makefile |  31 +++
 tools/power/cpupower/bindings/python/README   |  59 +++++
 .../bindings/python/raw_pylibcpupower.i       | 247 ++++++++++++++++++
 .../bindings/python/test_raw_pylibcpupower.py |  42 +++
 tools/power/cpupower/lib/powercap.c           |   8 +
 7 files changed, 398 insertions(+)
 create mode 100644 tools/power/cpupower/bindings/python/.gitignore
 create mode 100644 tools/power/cpupower/bindings/python/Makefile
 create mode 100644 tools/power/cpupower/bindings/python/README
 create mode 100644 tools/power/cpupower/bindings/python/raw_pylibcpupower.i
 create mode 100755 tools/power/cpupower/bindings/python/test_raw_pylibcpupower.py

-- 
2.46.0


