Return-Path: <linux-kernel+bounces-404133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F6B9C3F85
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40EBC1F232BD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A4619CC3D;
	Mon, 11 Nov 2024 13:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFsUscL7"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A4215575E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 13:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731331491; cv=none; b=j2fJ8Uu3DQ445E/57UtWG9LnUVecsaYBjw+M8/wvBNdciZe0umqU4t1vBD/jZOYrNT2ihyZq3cBo8ZkWwXl+vpoYFGo0Y9y7A4OpjJuDGtbcGDDt9d1kd5wU7G38+3uK8Ie8A5vZN/F/L4QUBkhGpg3S7nHNy5ivbOeW9m5UJIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731331491; c=relaxed/simple;
	bh=43M4L4MsqZ1gCcK/O6V85JP2VFIWZW99Dx3ZQ6qNa7Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=L7osBQ9XBmTemee3kcuoOhGVY0FXWNJhV6uJkTQWjIfsE71/szk+Jvpi8okEYHJ1PEJj7V08FB1p5YR3UG0r3K0fCumnFSBmWfsnWBzFSHWYOEZM0/rzKzZHY7P/gziIQnCY/HRsvKo9KRZYcpj7J08ZuCt4IZzqZJU+0DCa4Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFsUscL7; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c9c28c1ecbso5587405a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 05:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731331488; x=1731936288; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=43M4L4MsqZ1gCcK/O6V85JP2VFIWZW99Dx3ZQ6qNa7Y=;
        b=KFsUscL7o2U/w+5xhxCK9JLYQcTqYPlENaEWeifF/RZDDAy9Uw272LFuQyRB2cwTKE
         WQeeGyCsqHgsZ3tSSQdxYDtTFgdlWJJuNlBIkZqvv5eSU8OeJ7uSCk4juAMGvu6vn0DZ
         jrlvtaMo6d00UmPXKAcqDRGQwHnEf36VhCREfEewvyFnaYJov+QfsW0S9OdFVnkBkDg9
         KAOjVEs0ucaNV7GqyBVPSF90lBLDjNcER4R0dPRUdhIIc6Os7QJs/NYBojYIQRj5h0iA
         CEcNNvxs4nB3SugiLV6K4pboCGCiFe8jnFz3sCfgY6bVOjIrj+YmIlKI0AckcOvGqDhr
         IOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731331488; x=1731936288;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=43M4L4MsqZ1gCcK/O6V85JP2VFIWZW99Dx3ZQ6qNa7Y=;
        b=St5P7XZNnGt53xlN2Do9/Ek9085cKsLKK3UMTQNQ5COQng6aDjCX24YROr31xiPD6e
         VFT1rv33yOuE3z/EP1q8d74yksBhlnjhV2XDu2CavPTxtUS21LXH6gORZSkcuPeOc7aP
         weqRqw482DtvSSxODyS1MsWEJ8CIHVYMnIOrw4Y4FR18QB/2HSsiMIV2cgcboRsbAmhx
         Az3GTU98JChiamnBsiNgTUCSSHjKnmhZBKiRtQID7eOrZE/KF7iUYLw532PzoMHWIxXj
         EQYlgqLkUkscX4dkmgNcSakd517cjjkG+YqR45WZ6i2M9153BwIMHhK1e3vK1x2GApqh
         nqOw==
X-Gm-Message-State: AOJu0YxY3mG+v+MnF7Jpq4aVALd2HZgQ2dMuV94w6Zv1EHu42qV1Z9ac
	2BSAn/reB+8FOPFKqcqqFQIUyrG9Ld4/R7ffxWy1tWcRYm7iTleffblvgTYjQv8fUDmuElPCjPl
	p/ljaklwKnJlKeQQzHy5SCvbpens=
X-Google-Smtp-Source: AGHT+IFbSx0NTNsQJSupYvYRWir7CSJ7xB1DPfybMy8fwO8OanBGRLmnvsqBj5X0S4F5IfvfCElxQgemN9HG9N4vWO8=
X-Received: by 2002:a05:6402:34cf:b0:5ce:d4ff:606 with SMTP id
 4fb4d7f45d1cf-5cf0a471a69mr9260765a12.34.1731331488084; Mon, 11 Nov 2024
 05:24:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Mon, 11 Nov 2024 18:24:36 +0500
Message-ID: <CACzwLxjdRmD02Uu+3umNEvP-b9fXuT6WWS+a9gYhOeQEayK_ww@mail.gmail.com>
Subject: [RFC] syzkaller/docs: reporting kernel security bugs guide
To: gregkh@linuxfoundation.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Sabyrzhan Tasbolatov <snovitoll@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Aleksandr Nogikh <nogikh@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

Greg,
Could you please confirm that the updated version of
reporting Linux kernel security bugs guide is correct
since kernel.org is CNA as of February 13, 2024 and
with linux-cve-announce reference?

The updated doc and drawn diagram is available
in this PR of syzkaller project:
https://github.com/google/syzkaller/pull/5461

Please also see the diagram in the PR
docs/linux/reporting_kernel_bugs.png.

Thanks

