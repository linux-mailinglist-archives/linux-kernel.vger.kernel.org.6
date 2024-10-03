Return-Path: <linux-kernel+bounces-348451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BCB98E7E3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 02:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A140B2333B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 00:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E411FCA64;
	Thu,  3 Oct 2024 00:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="db96ZVvC"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84F7BA41
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 00:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727916140; cv=none; b=awPWZNMC1rDtL7yPiqTSfOwpRqEZl4m6rXT1d6GDjzl7gI/Z86+5iKWsvMYg9FVrK+Acol/SmkBGZ8A6c5B5GW6EQQeGV16kZd1hAvYwM9zzJ6DMg09nQqZ0b1qpX4zvVHURzmTvj73Yoy0dg8YM7fMIDGeYomnZRdTUBCI57LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727916140; c=relaxed/simple;
	bh=lte6mHdJXDHKGRg4oNA4pDk4ubaqoH7Z8GC6CPirNPM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=NDQUXhOhIL0cJvbRVA7aLddhmWp23+Lmlf6GikFyjrERJCoM8uN/FuTcB3XhkZgusbgAplPxblcs9UrSO+JCwarQZF8Xy0dAu6c7bHs5J01Mdn2xvtWOuhjkwrat2PtoQDjMhjhG2cpzNfqPsvMHPR6oFLx1gBUtfGBq9ZEHaiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=db96ZVvC; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5090e09438aso139553e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 17:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727916138; x=1728520938; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lte6mHdJXDHKGRg4oNA4pDk4ubaqoH7Z8GC6CPirNPM=;
        b=db96ZVvCcupDloQEocCliNpM3q59Qi/xbjOpcvXcyH72hnyNrdUzSkws5y1u6V4vUL
         os1NTmzYVCrb3MeUYrnImQ7/9R5FbL4P4/Tbp9l/Car+fGf2vKfXq7G33CUFx/SaeuOs
         9TUSiTrA2qVyHeh4OlmDayTP+u4FbWU6PFNSDUgWuWG+qUPx/zzmrrxmlj4gYS6vTnd/
         aD9AVdfuBNDAWze+yDlX+wtRn4sADW9C4oBCsYrprC/8yEnwHCLEu0mIMb60EmFiPlbc
         DiP1OebPBPQW6/FMZhwcmFAiBcLFB3MUjnExa+KHhfLCpj3sa7LNKpLJCvxf4UFWq0we
         o/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727916138; x=1728520938;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lte6mHdJXDHKGRg4oNA4pDk4ubaqoH7Z8GC6CPirNPM=;
        b=lrhv3goMEi/qWFfKkzyJTHlMauePIg3h44lNGI9M6mK4tFVqIh8S6u5DvFD+A5wTsn
         FW7uW6PlcC09qU/SJD5rB8WF1QdcjmfxzilUM2NDfpmE16imbjrHE/y0AE0HgLYBLTPU
         lEuVaRc16aT4XAMe1XdBIGL8yEc5W/aspAj8q94h3kCbZC6/xQs963KXyeOmQOTuD9bw
         4GGCgTwYo7jyC8HdGcYL0i4ncd1CBg1qqHUY6UE56aJSZ2EICQDbX2rGw62KhmEGU5rX
         HPgkFnXi5ThJy9Qr0hcMs3DtXoeipp4My+qeWKafcejNIZtkbx5GQLRczxfs+v47o2EW
         vZdg==
X-Gm-Message-State: AOJu0YzMcnvKC/UZivfLh+3a9TXMtKaO1VkvZo9i38TmRm4ZgtIwh7ig
	fWJGkGjcglIUOIhWr/EJ2nhPynSYcDuu3NHc2jatqj4wGfJ4ZoxrUYdzeLqRF12l3cXd8oR8vRu
	RMsrJvyT7+xxCF/ptFtEz2OJUpfFnmQ==
X-Google-Smtp-Source: AGHT+IEmROyKVlfvHWRbfvULtQFPA6sYdGWsREX8cGvA8gIDg2gYgrueR+wWZG4QAFzSY43GlBd86t+C0Sa/JmRqMUY=
X-Received: by 2002:a05:6122:2017:b0:503:d877:b049 with SMTP id
 71dfb90a1353d-50c5814b0f3mr4832473e0c.5.1727916137557; Wed, 02 Oct 2024
 17:42:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Joshua Hudson <joshudson@gmail.com>
Date: Wed, 2 Oct 2024 17:42:06 -0700
Message-ID: <CA+jjjYTX80h7mRtxnYu2a=MNu5fuzxVRG4v8d=u0np0SD37qEg@mail.gmail.com>
Subject: Probable bug in renameat2 with RENAME_NOREPLACE on vfat
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

System call:

renameat2(AT_FDCWD, "makefile", AT_FDCWD, "Makefile", RENAME_NOREPLACE);

where the current directory is on a vfat filesystem such as a USB stick

Expected return: 0

Actual return: -EEXIST

It's just not right. I really shouldn't have to remove the
RENAME_NOREPLACE to correct the case of a filename. Basically, if
oldname and newname are the same dnode (not just the same inode) the
call should proceed.

I'd rather not lose the race condition safeguard to correct the case
of a file name.

