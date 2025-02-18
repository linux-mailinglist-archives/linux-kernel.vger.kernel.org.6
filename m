Return-Path: <linux-kernel+bounces-518927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51258A39640
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B2DF176DD6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E885D22D4E5;
	Tue, 18 Feb 2025 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=i3wm.org header.i=@i3wm.org header.b="H6I9UgWn";
	dkim=pass (2048-bit key) header.d=stapelberg.ch header.i=@stapelberg.ch header.b="AGMqCj4Z"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BA91EB1A6
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 08:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739868854; cv=none; b=WEMDxwUt2nmagd7HQMrIgmRIjDskUUUy/ENpQ+C1PzYLhh+yGMsNgVOFGyi2ifAuy1+kOWQYyXKsD44PJ4jM+l7KQx6mRM2KzbeNj2nmbMI8PqaoZgEXwFaeVz8QyYG14miv/R/SDwcgj+qFu62ljJh/5lD8cH+ginZRXGZ0+no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739868854; c=relaxed/simple;
	bh=758zpFMpsf4T0pGdRX7PvDeXZaVnukHdlST1KAQoIy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ma1lD8qbcTUXqMyuKpv/GOPRcH+VMmJM+BPMgGDWeaihUr4MgdNHkcNnKYahYL3EyRuD+Ign8Mc6NRSq2cpRbFHgz0jVRryaJSGh/qSzC97mXv/gui2qNlwAu0dZSxf2BbE9a0/SvD8k4aHXWBh+5WyQIe4FcNkoMvwqQTho8B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stapelberg.ch; spf=pass smtp.mailfrom=i3wm.org; dkim=pass (2048-bit key) header.d=i3wm.org header.i=@i3wm.org header.b=H6I9UgWn; dkim=pass (2048-bit key) header.d=stapelberg.ch header.i=@stapelberg.ch header.b=AGMqCj4Z; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stapelberg.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=i3wm.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38f3486062eso2187681f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 00:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=i3wm.org; s=google; t=1739868851; x=1740473651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=758zpFMpsf4T0pGdRX7PvDeXZaVnukHdlST1KAQoIy8=;
        b=H6I9UgWnz8q+ewmMM6mN862rcFhAJlYTZn7OQwFz1hU9ZIq0qH9ruX722w6V0pYv7p
         IRuaxapJUVpB/AcvorraDO57ElRcPqHcGQUB9qFYJ/Zn0i5uugYxjTC9rcj6mD6pso6Z
         AOu1Vh7aQtdhUmo9nfLFFw03qKZO77gTZ+3VBVpp3zuXigtai2TXiqGi79vSQqw+H0gZ
         VZbKPenn8G1WnH88onUv2+cr8F0L5oWrNjaOSvISFUnzSR7FOxoSweeowYMen8kf0HvJ
         YvOVC+neTtKaEYj4WyuxC+oNf+d+Qxj2Rjaj2b5EY7XJ+r83oTlTBvJcJq8oubQMDl+0
         4IrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stapelberg.ch; s=google; t=1739868851; x=1740473651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=758zpFMpsf4T0pGdRX7PvDeXZaVnukHdlST1KAQoIy8=;
        b=AGMqCj4ZgiJ0LoTjL0n5i+6I/hypqWSm4moAy4RnCy1wShZiSKF64hIuzeo/lslIrq
         qe0pPWyIFt0ZNTkSwwMiK48adnx2VWdxdQoXG2e0Wn503O5jlDhrRNats170yJfkKi4K
         n7tYTG/FQveWKouxgMRKVl31bAxuEHVxRu2Bx6SCYvb/PDjmQZKDRYtibWpZrFnOlIso
         Lsfc5Hi9x4WMsWq5IwMArGBYzB6SuSusccKGUQcIwLsxvZzm2h3OcA3DZlAA8+SGIeJH
         NOD43M44KvxmkUeOyYOloGAJ3SAmaOyIGV11AuYYxyZjPk4ne0nDJmynR12P9OFMLd6r
         yHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739868851; x=1740473651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=758zpFMpsf4T0pGdRX7PvDeXZaVnukHdlST1KAQoIy8=;
        b=GXuDNDOdJMuwWeCpUBvWs/pv1l2Y690libDqYeQCZz3qNLiuzJdxDPmqirN2jIGZH5
         EPrXA5K5Csmyxxxzqr5yNfeSoU6L1o05tQjqzQiupbnXYimJ6eCEDm33YVbI60GVzCrU
         12kj2jMTM0HP1gJSTdjHU57nyQiHdhedGTWUvPofPOOAQ9IXEdD/GzI/njsbnbp9hLIP
         YsLDXs6fuJvudHjtKJBXzq2wNXBfmtPUAGtmCSM3tEXq4VCHTzlwGkehWqG2XdQtNggf
         YuCniSXOYYPPWrs0bMbudTb7n1T3h0dgiWBQj7EXR1gN7K6ajOqGjsq+gguWaGSR8OaH
         c9TQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTbyZSm0pxgAhpfL+FNsNA6ashSjxyvdRxVaRX/BXnbyDZMti5moVUZKnqHPPDtKmzpGCoTjuaHBNZh+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr1XXnONgzbQRuOULd/rTGOd+17x+5FK12LBAS5I5DqSatkJQz
	bSc+nfy18PIdZxFPC8kkL7LjqE81NuP4f+KkwkC0V6pYYj4SwOf3kSwR0c9ZdgJ+5D4q30ElWlJ
	s
X-Gm-Gg: ASbGncv7t5GUFV48yn+z2IIpa3XKlSX5rdCFzQUnyI9EbjQ9gooNy7rnn9NyMiaCYni
	mi7UO9K07rpqjeVD7Ptspvl3gsFPmx5Jj2qwA0Tw6YyOppHSQKGnpJsDfrvam3vzp/5cJ66afjw
	6tBiUBzOMaSPiMwC+I4rBgDTM0EERMFQP7zCSRbscg1DmABdzCvMKrGAJczC/LKxRkH4kXjR2ZZ
	OsuGO9/kKnnXjIyFajZQX4JEdYTnrlFa/LvGnE7SclqQu14EdfJ/Sow0PhArJkcMXzaP79+l2+w
	US/Lmv13LfcMIA==
X-Google-Smtp-Source: AGHT+IG9SYoRvEq3m0HtuwXoCMJqDOynlqQun7kLkdRbUn0QNGwSb00dHbCF/DGeSWjnCNLlYUxPOQ==
X-Received: by 2002:a5d:498b:0:b0:38d:e411:7dcc with SMTP id ffacd0b85a97d-38f33f44cd8mr7957635f8f.37.1739868850622;
        Tue, 18 Feb 2025 00:54:10 -0800 (PST)
Received: from midna.lan ([2a02:168:4a00:0:62cf:84ff:fe65:d9e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4396b5267eesm76997295e9.0.2025.02.18.00.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:54:09 -0800 (PST)
Sender: Michael Stapelberg <michael@i3wm.org>
From: Michael Stapelberg <michael@stapelberg.ch>
X-Google-Original-From: Michael Stapelberg <michael@stapelberg.de>
To: makb@juniper.net
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	kees@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	oleg@redhat.com,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk
Subject: [PATCH v3] binfmt_elf: Dump smaller VMAs first in ELF cores
Date: Tue, 18 Feb 2025 09:54:04 +0100
Message-ID: <20250218085407.61126-1-michael@stapelberg.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <036CD6AE-C560-4FC7-9B02-ADD08E380DC9@juniper.net>
References: <036CD6AE-C560-4FC7-9B02-ADD08E380DC9@juniper.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey Brian and folks

> […]
> backtrace, and it turned out to be a non-trivial problem. Instead, we
> try simply sorting the VMAs by size, which has the intended effect.
> […]
> Still need to run rr tests on this, per Kees Cook's suggestion, will
> update back once done. GDB and readelf show that this patch works
> without issue though.

I think in your testing, you probably did not try the eu-stack tool
from the elfutils package, because I think I found a bug:

Current elfutils cannot symbolize core dumps created by Linux 6.12+.
I noticed this because systemd-coredump(8) uses elfutils, and when
a program crashed on my machine, syslog did not show function names.

I reported this issue with elfutils at:
https://sourceware.org/bugzilla/show_bug.cgi?id=32713
…but figured it would be good to give a heads-up here, too.

Is this breakage sufficient reason to revert the commit?
Or are we saying userspace just needs to be updated to cope?

Thanks
Best regards
Michael

