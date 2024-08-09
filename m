Return-Path: <linux-kernel+bounces-280911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8002394D0C6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 301E42859B6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2435194A53;
	Fri,  9 Aug 2024 13:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMazjyhI"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C4017BBF
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 13:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723208617; cv=none; b=dRgKDii5WVbP//N7IYitAGKputsa5rvgRhU6dUMsUP9xmcHS/n0XFt9tsNe4MGfurBzHC7dJgLD6/zthwpQmEtpIOOw0emOIuG5tM1nYWwlFUdWDC4hGDBA252/lSUUC65LL0fcTpJv93/9C1Q2udt4jXCvLxp91MyJTEFz7ee8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723208617; c=relaxed/simple;
	bh=3m1pZxPhGzTl9v4qiiLVhdqd2onNcoH4RUH556QZQTA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=K5Em0YkE0TpZKdgyjpHywcGFRwz1sJtuZVJXXoCTcI1/Uhig5Y/u8fi68gm4fOs7k2LGk+wGW5cQgk2gPZnR2iRnSUdH5uX40/9DjjWPVbP2Q1viXycw33ulv4YCHFxoCgkqfO4gOhCNfisnPzu7bEFc+EoozeZ4ZtWLQSxTFUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMazjyhI; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-39b3ffc570bso8703115ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 06:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723208614; x=1723813414; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hymiwhg9/2lqr04U1VD6nWvguE8GOLKvEYlC5aK96lU=;
        b=KMazjyhIVFlm5HzcX3tPb5Hw3qfbJ0KNzcmH3fkb7eMXjF7atXdbjMxCgCI2gy0YZM
         KwTuBGN8+kCTJLB+tYbgcJ1m1PKNY4cEecL+t5lAet19yx4GP38jPbvXnQ9DmJiqNuph
         lPX1LSEKabx03v0iIBEoxylyXpxCOqJZbkpdqzpjKL2AUCcssUKA3owT8qEkyOW6d70W
         +PNrHCYT5aek1Xz1d0JzIdseU5pN6rkhNV156hni61mOJGCGRRxeKXbxozbWfFEEXfB4
         4h5YmoWUpgRJ3aNDLJdw1mXv97d2FP4dSWbuulaGWa0bG1ELIaghNWkDzFIzP4yii07l
         syog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723208614; x=1723813414;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hymiwhg9/2lqr04U1VD6nWvguE8GOLKvEYlC5aK96lU=;
        b=S8P8m4CjXYMVvfcB10+q57DV0WE4IR30unmBuhgqxCZvR/ld0UVqjL1Vs/Sa06zCuB
         LmJEtbgunbhmPZ35i7StkTGDMmxgqsuFZL67O3RVBhpSAnoT1EopFJoqYiChH6Fj5o7P
         pKiY3vjMFt54vwVd2J7goH/Oxr4Kr8kPW67Bp1Am6AAbuQcy0yBh+hur9E+YAOOexz8E
         Qcgtq/76N2TednuNbXfvz1XlVX+VAK7IWugbsIdWdlGLQuNN4+siqlRQ3aL+0Yt304s/
         4j1RA53y3dqqDQc/wH/NzjITPyNZjr3XsPTz/jzXpv8UljfoNmTHk9Fcsmz46DtEeZsH
         pZWA==
X-Gm-Message-State: AOJu0YwUrZ4iFR1hUWjZ+DwibPfZx41pqAjxszmEX9dy5max0oKlsWUJ
	iU4H/wVuwdUXOjXsR7CT2ErD6vHeAkZ23lgpk1iVl0eTe7BcwrZGRunDxpjc
X-Google-Smtp-Source: AGHT+IHKddaF01tn//hHIPAtYB+Zx+rxlS39zBB4++n8QO44xz/QUxX1hNUPI25cGKI0VHnfWGzQiQ==
X-Received: by 2002:a05:6e02:12e8:b0:39b:c39:816c with SMTP id e9e14a558f8ab-39b7a4286f2mr21483655ab.16.1723208613632;
        Fri, 09 Aug 2024 06:03:33 -0700 (PDT)
Received: from sarvesh-ROG-Zephyrus-M15 ([49.206.116.12])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb209fddsm2564784b3a.27.2024.08.09.06.03.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 06:03:33 -0700 (PDT)
Date: Fri, 9 Aug 2024 18:33:30 +0530
From: Sarveshwaar SS <sarvesh20123@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: PATCH: Fix spelling/grammar issues and improve consistency in
 index.rst
Message-ID: <ZrYTojrik5kD7vRW@sarvesh-ROG-Zephyrus-M15>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="r9OBn74I9pmv9M6O"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


--r9OBn74I9pmv9M6O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Please find the attached patch for spelling/grammar issues and improvement in consistency in index.rst.

--r9OBn74I9pmv9M6O
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-Fix-spelling-grammar-issues-and-improve-consistency-.patch"
Content-Transfer-Encoding: 8bit

commit 74415fda4ea86acbd185027356658fb342752a0c
Author:     Saru2003 <sarvesh20123@gmail.com>
AuthorDate: Fri Aug 9 18:18:43 2024 +0530
Commit:     Saru2003 <sarvesh20123@gmail.com>
CommitDate: Fri Aug 9 18:18:43 2024 +0530

    Fix spelling/grammar issues and improve consistency in index.rst
    
    Signed-off-by: Saru2003 <sarvesh20123@gmail.com>
---
 index.rst | 128 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)
 create mode 100644 index.rst

diff --git a/index.rst b/index.rst
new file mode 100644
index 0000000..bdfd296
--- /dev/null
+++ b/index.rst
@@ -0,0 +1,128 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _linux_doc:
+
+==============================
+The Linux Kernel documentation
+==============================
+
+This is the top level of the kernel's documentation tree.  Kernel
+documentation, like the kernel itself, is very much a work in progress;
+that is especially true as we work to integrate our many scattered
+documents into a coherent whole. Please note that improvements to the documentation are welcome. 
+You can join the linux-doc list at vger.kernel.org if you want to help out.
+
+Working with the development community
+======================================
+
+The essential guides for interacting with the kernel's development
+community and getting your work upstream.
+
+.. toctree::
+   :maxdepth: 1
+
+   Development process <process/development-process>
+   Submitting patches <process/submitting-patches>
+   Code of conduct <process/code-of-conduct>
+   Maintainer handbook <maintainer/index>
+   All development-process docs <process/index>
+
+
+Internal API manuals
+====================
+
+Manuals for use by developers working to interface with the rest of the
+kernel.
+
+.. toctree::
+   :maxdepth: 1
+
+   Core API <core-api/index>
+   Driver APIs <driver-api/index>
+   Subsystems <subsystem-apis>
+   Locking <locking/index>
+
+Development tools and processes
+===============================
+
+Various other manuals with useful information for all kernel developers.
+
+.. toctree::
+   :maxdepth: 1
+
+   Licensing rules <process/license-rules>
+   Writing documentation <doc-guide/index>
+   Development tools <dev-tools/index>
+   Testing guide <dev-tools/testing-overview>
+   Hacking guide <kernel-hacking/index>
+   Tracing <trace/index>
+   Fault injection <fault-injection/index>
+   Livepatching <livepatch/index>
+   Rust <rust/index>
+
+
+User-oriented documentation
+===========================
+
+The following manuals are written for *users* of the kernel — those who are
+trying to get it to work optimally on a given system and application
+developers seeking information on the kernel's user-space APIs.
+
+.. toctree::
+   :maxdepth: 1
+
+   Administration <admin-guide/index>
+   Build system <kbuild/index>
+   Reporting issues <admin-guide/reporting-issues.rst>
+   Userspace tools <tools/index>
+   Userspace API <userspace-api/index>
+
+See also: the `Linux man pages <https://www.kernel.org/doc/man-pages/>`_,
+which are kept separately from the kernel's own documentation.
+
+Firmware-related documentation
+==============================
+The following holds information on the kernel's expectations regarding the
+platform firmwares.
+
+.. toctree::
+   :maxdepth: 1
+
+   Firmware <firmware-guide/index>
+   Firmware and Devicetree <devicetree/index>
+
+
+Architecture-specific documentation
+===================================
+
+.. toctree::
+   :maxdepth: 2
+
+   CPU architectures <arch/index>
+
+
+Other documentation
+===================
+
+There are several unsorted documents that don't seem to fit on other parts
+of the documentation body, or may require some adjustments and/or conversion
+to reStructuredText format, or are simply too old.
+
+.. toctree::
+   :maxdepth: 1
+
+   Unsorted documentation <staging/index>
+
+
+Translations
+============
+
+.. toctree::
+   :maxdepth: 2
+
+   Translations <translations/index>
+
+Indices and tables
+==================
+
+* :ref:`genindex`
-- 
2.43.0


--r9OBn74I9pmv9M6O--

