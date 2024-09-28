Return-Path: <linux-kernel+bounces-342365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6ABF988E03
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 08:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D41C8B2188A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 06:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EFC19AA57;
	Sat, 28 Sep 2024 06:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVuDXN0M"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949032B9C4
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 06:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727505716; cv=none; b=HnqRXtHMFVFE2q6+Un1nYrXZ9fgzb9RT7nuKLufG/HeRycCYbOXHD4UuBrSR1yRmPp+Dgx0dFkC8eotyY9qnjIZ5fCCtPYE8BvM4cjpgX3zpig786uZu61xk5UI+Ede3gI9Dn3VXMKohPYZLmVC99JulmVu0yK/4Aiukd9KQFOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727505716; c=relaxed/simple;
	bh=hohxMTxQethsIWRoiB14dLQnbLIuOcR2yQ5yh+PcjpI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IN8AtXqQxwT63TA/FMiDvZKHOQV9midB2lCRhIlFo1Li6CH+JmN2BOJYA4Z7Ro2A+qhUdZ71Gad4HQ04b/Bb9jveaq0yC0s17vFF28cMkqZjniSWHHMwI+1s/c4DOoCFPKkEM1/fVr3f9xtPpsngkEKaLBBFND98pKcgR9oqlsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVuDXN0M; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8a7596b7dfso296531266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 23:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727505713; x=1728110513; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uH7S6Xq2sV29pgWZbyWfpT8hYgZEypeg62JQ0Swnw+E=;
        b=VVuDXN0McKZf67KCmcmJC48Pj9IXPKahvIVcWQVZtfRqnkr7PLk3w6AsFzqaHiHufj
         DwVNYvRClSgeWiAjQ3iDKQ+m2yQZXIXnUuSHrRo05dHp9cuTTVv8d00WzYQnFkdKLyfr
         xFsry+nBulOMsvNkBO+xTYciCWv3sYNRir3TpBEWhY6XClXAEhdBk8JX+3K3LqK3M/fb
         qXWeOt2ldb5DNV4Rqfz30zReCUlTgITj91sXZvVsYiw30ViK1Q196iJMfg3M6NqBzW1G
         WCIT8HY7OaGAUGkBD6QwQU4iadm3AwghTSXUO31JyVo4JY9fs6ugeHkrUGe4rqYEmALR
         Zmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727505713; x=1728110513;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uH7S6Xq2sV29pgWZbyWfpT8hYgZEypeg62JQ0Swnw+E=;
        b=lQZjR5LFx4pkBLevxnJnuxI5rFECA8KPa3OiWpyvyJv9wdF0bYxRhgsKgla5uubcFu
         v9asV64ewUSAIpsA69WeAjRcBqdRscBojAf6izArGDXKSJV4HkVA5PFA2eaY7ryX3ev2
         nhSTEz1YgVWKsLE1OLP292unxASuDxPiWSas/JJPRQxO2whr3BSvLUZaA6RRwzRwTMwN
         0IYJeMfEQh2oNqPe0f5qpMHNlajG4ZF+o2x6nTdbYm06ggeIFBVJbmEn3koZx3BRnCmA
         5fOBVYb7h87lN0AoXRgsQBKXprWzVgCJHLx1Sy0+RKvcsKTdVJRtKNv7cuLsyUEL03U3
         /2Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVN4ctPkPvLB8nEA/LjdWaVyZz8EEX5eoKPT6q3LFphekelq8xFMDW3uNn9g7W05GinkbJPmKYpaM99C1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd+TMqITTOlxadGWetJ55vlcbyzc4olv7fi81dryp6SAoot/6c
	L6XQIE9Yd2buvpH5BFOmfeTodZ6MSp1uZmnPbJ2Kft5VqBn3n7K4
X-Google-Smtp-Source: AGHT+IGSkht1tn1jLB/bKu9698R5E8LZ6ZFAYrtcsOOHtTHhh8tTP/LMcVxcQugV8y8x/7R0Mn2r/w==
X-Received: by 2002:a17:907:1ca7:b0:a8d:3ee9:12fd with SMTP id a640c23a62f3a-a93b12d43f1mr1030948966b.0.1727505712619;
        Fri, 27 Sep 2024 23:41:52 -0700 (PDT)
Received: from [192.168.2.105] (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2979e00sm214526466b.158.2024.09.27.23.41.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 23:41:52 -0700 (PDT)
Message-ID: <50020db0-3bad-41f5-8da3-c66bc0a90fe6@gmail.com>
Date: Sat, 28 Sep 2024 08:41:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [RFC] staging: gdm724x: Proposal to delete drivers gdmtty and gdmulte
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Jonathan Kim <jonathankim@gctsemi.com>, Dean ahn <deanahn@gctsemi.com>,
 Won Kang <wonkang@gctsemi.com>, support@gctsemi.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>,
 Larry Finger <Larry.Finger@lwfinger.net>
References: <f82fffbf-a983-4ab4-897b-b5a810426f04@gmail.com>
 <igi27iwrzg3ovgj3sym4gsi45timpkt4vkl5ss5dbftdzat6p4@ctxcjocvunpt>
 <78b521eb-4e89-4c01-8dfc-1fb990e6887d@gmail.com>
Content-Language: en-US
In-Reply-To: <78b521eb-4e89-4c01-8dfc-1fb990e6887d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Sirs,

Won Kang from gct contributed the driver gdm724x to the Linux kernel 
staging subsystem in 2013.

The following points let me propose to delete the driver:
- This driver generates maintenance workload (for example  CVE)
- The manufacturer is not interested and does not care as Emails or 
inquiries, to support or involved persons of gct, got unanswered.
- Did not find a possibility to buy the chips.
- Did not find minimal documentation on the web.
- Did not find a device where it is build in and the user is able to 
install any Linux. Therefore it is not possible to do any testing of the 
driver from the community.
- No blog entries about anyone using the gdmtty and gdmulte.
- No response about usage of this drivers to the Email from April 2024
https://lore.kernel.org/all/78b521eb-4e89-4c01-8dfc-1fb990e6887d@gmail.com/

Thanks for any response about your thoughts.

Bye Philipp

