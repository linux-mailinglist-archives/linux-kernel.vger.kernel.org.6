Return-Path: <linux-kernel+bounces-445758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 490019F1B34
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 01:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66564165ADB
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 00:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8731F37BE;
	Fri, 13 Dec 2024 23:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kfhldL39"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841E01F3D4A
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 23:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734134305; cv=none; b=YvIDc3oiJ7ozt5kb8dljYsBEMEbXgXk3NQHRjXYdUlTIHjsxTxL7tqMvjShdwZVN/9AelO3O9vBj4bTYMoKEh4Fz+OkzHnScovCkWgzowVxiJhQRtZNAfXv+ETTeTaSVsXgULkc1IRBrtavCgXPek7ZzXV0bQj/lTQeErFrsgL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734134305; c=relaxed/simple;
	bh=OGq5+hgs9dJ1yb7kwu/w29GCqzBZmKeO5Y+Ru+siBvE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CpBgW3AC8u1oR4iBPYqKrLRIuI3Rc2BT4GgEwKGMHM44vwbKrl8p3b8gb9/noIdqSV4TvxnEg2x22ldA3RdIjKpXTl2Bab+jCqNFjemWkE3HAkKfycaeZiiwDUn3dib4AXyZ+jJzPTa+/RJ6Eu0/VDHumP3p3gbHphwNiLgJ7N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kfhldL39; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef8c7ef51dso1897845a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734134304; x=1734739104; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUgYlM58E1ID1zBsFizknmN76M0X0I58a2gj7PTiNA8=;
        b=kfhldL39TBzg9mfNZ38MUKouWW9n3KF8rCW8KQmRe1H0hGO3EhPDeZXjXTlhoquyrR
         1CLApWPe8V31MNazpfb28xvW+4gfohLNIfOLrlVr482N2e/jfUbauX7klRetYEEht73L
         gsZnytOQRypwAUUOoDHoiJ6qgRHFavAGtEBu9Bc1zrQ2Myg55pMRCiyhcLxQPAJeDyDI
         3vCh5/hwZ6bZ7Oh/3S4u20eKFDUlPzDMTQCmD0b3FBFrEgDrJmh5liv6r9qb7o0mFqH5
         2xqUzIYFRK0unNWhPBqWsHEzecJ3EWI/lM2KQXPhNUyt6doxo6BZKmXkvUDO0cCRq4Lg
         eyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734134304; x=1734739104;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pUgYlM58E1ID1zBsFizknmN76M0X0I58a2gj7PTiNA8=;
        b=YV27HyrjlvdGtS1+oHHMwnmYLsm0wkMPb4gB0pjk7RV4p9zHp4k4kGXwPjy990CxC4
         0RA6BsoUFfdsATaxBju5V4sjs9DlYCdqf+QdxRV+mUqof/1XDQWxZziwAbz4AZBF+2eC
         jgOZf5adogq3irnL8XHsvAvqZ40J0I9ojrQp4l6LmWRbSIsFwI0y+ZfnRGhbxLYCdYKp
         2tiYAW6VxEVv+Zm4Z30gQ7IPwo+GNXjHdOuo5ZHRe6M1VaYoZWrllowekfyJL4ytFKCT
         KlUfYxA0TA6CMWTGQLLLXHIpV1V1PijEe8vUIR2RANG7yNdWjUSf9af4S4PJu5EJxGBy
         bZZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqi54uY9Ke5jEoq7o2i1DyRtQOVaWJskxd0jMMS7DTXwclUzuH1KfXyjq5+kDULYfKV6hc+TByglN+328=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK9D7CIbSVzBtEjM7EZJu+HAQ+XhlhhOnz3PLFQRP8pQP0UXDc
	dlMhFbHmJM+WVDGhulC02xD2mFgjuDVsvENdlhk0p84kSnFiauDao+JIQ+Sd1hK/Sdy7HhheawM
	eBQ==
X-Google-Smtp-Source: AGHT+IEx2eqGQFBGQTUi/pn7XgE3bLWI9EM+6VGiZXjWJeNOX1FQChOgohoyAT6tKICqO9oQPQKyJbJfX0k=
X-Received: from pjyd4.prod.google.com ([2002:a17:90a:dfc4:b0:2ef:973a:3caf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c02:b0:2ee:7e53:bfae
 with SMTP id 98e67ed59e1d1-2f29166c324mr6176343a91.10.1734134303859; Fri, 13
 Dec 2024 15:58:23 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 13 Dec 2024 15:58:21 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241213235821.2270353-1-seanjc@google.com>
Subject: [ANNOUNCE] PUCK Agenda - 2024.12.17 *** On Tuesday the 17th!!! ***
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

*** LOOK HERE ***

Due to holiday schedules, next week's PUCK will be on Tuesday the 17th (regular
time), not on Wednesday.

There is no scheduled topic (which is code for "SNP, TDX, and guest_memfd").

Time:     6am PDT
Video:    https://meet.google.com/vdb-aeqo-knk
Phone:    https://tel.meet/vdb-aeqo-knk?pin=3003112178656

Calendar: https://calendar.google.com/calendar/u/0?cid=Y182MWE1YjFmNjQ0NzM5YmY1YmVkN2U1ZWE1ZmMzNjY5Y2UzMmEyNTQ0YzVkYjFjN2M4OTE3MDJjYTUwOTBjN2Q1QGdyb3VwLmNhbGVuZGFyLmdvb2dsZS5jb20
Drive:    https://drive.google.com/drive/folders/1aTqCrvTsQI9T4qLhhLs_l986SngGlhPH?resourcekey=0-FDy0ykM3RerZedI8R-zj4A&usp=drive_link

Future Schedule:
Dec 17th - No topic
Dec 25th - Canceled
Jan 1sth - Canceled

