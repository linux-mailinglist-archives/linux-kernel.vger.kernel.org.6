Return-Path: <linux-kernel+bounces-411787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0B79CFF9F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 16:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68215B25103
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 15:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED403EA76;
	Sat, 16 Nov 2024 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b36hKJ6g"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA10144D1A
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731771639; cv=none; b=JFWrFcu6/V6IakjWArxzt7zelNl5zJZx3VfX/m0U6jSB6hbc4eKBAB0Vayp9ggyRdWLRqfYfDd/dtcGNSXNzHADs6aUpDGAXcE/DYq2z/IftoEu4s7rjh5KuE5dTko9w5ZIO/teX7KXmlWWu0tZoin0M2ElXgYybmpE86W+HsJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731771639; c=relaxed/simple;
	bh=Wd+7kLQISUZlzyPvYmSUTVOb8NV4Vyd3OpsFXw6X7a0=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=TlJDW7ijvbDtTmU7baCIlg5lvIWbqwaen6UYx6oDvUPrCcrVybl/yajEqoUqYHKCItZZlYIzb0dLkjtRweghK295UizkZJHoDW+hZs97+mUu6L/ae7ZoFUK62RQXcczbuaavMzxWx8n9oamm6/LKm84GIB2LqXq5XVyjMhpSxFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b36hKJ6g; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7f8cc29aaf2so896901a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 07:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731771637; x=1732376437; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHEOkgJ64rwJ+cv0sVIqPUmbc8l+iTifR7HzGzNced0=;
        b=b36hKJ6gQQncBj4DAuESdzbJIO03TFjIaKP3FnKRT3dCHkU3lVbv3l/lJkHYpXKqgE
         5TmJoGvB/YhaLRqehE6VYQ08a2X97qyU5uci47kSCFw68PPMg+WaZOkX2kt/MALbWYqv
         aRgeTPM1a4rFbGztgfWEzwH1rZwiEzH23GSivENJZIhdoRoihvgHDu7KymQcQTBpErly
         JKR2L/+BKregRsTRUxjc0k25iEQwRwPQVn4Top8JMhB7RkzikfhYtz45/LCzUJdbuiLi
         nE9tsqBmKBSOWTQPUclNgbNAW9hKYdkSePK/oLXl/RYFMsHH0KM8Iu8CHKC8MKeZRCVM
         3+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731771637; x=1732376437;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHEOkgJ64rwJ+cv0sVIqPUmbc8l+iTifR7HzGzNced0=;
        b=hWoFoPhKl2EWjWofF2YfZThYJ6Y/90VeeUnbASrwEJkNpGy/gL6l/TFOPAoAddJbHx
         qcpGoqXMFz9SNs0qZw3U237I8sv5mZ4h/EdsRQLTAYOb6/wNqsH9thu3vVy1sn/ni7Xm
         mbI1Fq6IYZQIs3VBWc+6sj4NmPHBSMAdy/qTiLTrG86nDbBHcPXoGDUMwHcgB8G+Afpz
         VwZETkCS4fbMK6kJiv0+Yath/+JF07MpnWkQZcBJ68+ttQ2fq5FxARWOpkEMKiFptji2
         q9XovY3Ukh17RrTI9KUyDy/FNytrjvr2lzjF5HeX8oUt0uwvqoRNE7r0Ku3+45By8hmh
         vO1w==
X-Gm-Message-State: AOJu0YzRSYm70MPdS+OV/Rqv853T9i5tb4LIwu8fWf/HL7gKk6CFpsbY
	zYBQV7puuH+t+Lmwg7aGy8FuADkGGDjugE/t+SmwvWUcPB186UTxnguH2Q==
X-Google-Smtp-Source: AGHT+IHRXBxFgJvoygabyn9sROQMrbJ8AchOkzjbLQLMyRVBTpGhtvybLiGwbRVyjhG9RvpncfOTlw==
X-Received: by 2002:a05:6a20:12ce:b0:1d9:2b12:4165 with SMTP id adf61e73a8af0-1dc90b1fc14mr9333054637.13.1731771637145;
        Sat, 16 Nov 2024 07:40:37 -0800 (PST)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1dada40sm3086249a12.61.2024.11.16.07.40.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Nov 2024 07:40:36 -0800 (PST)
From: "Van. HR" <sk0673130@gmail.com>
X-Google-Original-From: "Van. HR" <infodesk@information.com>
Message-ID: <a56e712e53bbde3a6279c41d19f98dc9ba177904b36fc316b73c32be6a0f89f4@mx.google.com>
Reply-To: dirofdptvancollin@gmail.com
To: linux-kernel@vger.kernel.org
Subject: Nov:16:24
Date: Sat, 16 Nov 2024 10:40:34 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,
I am a private investment consultant representing the interest of a multinational  conglomerate that wishes to place funds into a trust management portfolio.

Please indicate your interest for additional information.

Regards,

Van Collin.


