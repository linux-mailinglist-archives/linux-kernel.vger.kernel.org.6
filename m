Return-Path: <linux-kernel+bounces-198452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DB38D78C8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 00:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A162811E6
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 22:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352732C69B;
	Sun,  2 Jun 2024 22:19:22 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70335AD59
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 22:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717366761; cv=none; b=dEZFzZRiOp1R3IPecazCH8Vt6g++z2UjIEiEDSFexSROwXQOjeRiHeK7vh9ometP6PV4PwysTnOfJ4gxSBc/Fnfcmm9delYSw0UdxwArcBnKUk8Kg+SvXXtbrx4Ozl68u0ofLivng9iBR/OrOMLK/C8laBJuN34M6/jyT3cDy7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717366761; c=relaxed/simple;
	bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Qy+I/J/egoDYL4J91NbJ4gQDYHH7GhPDxFWNwnz8XvO7uAaLQIrtsdZ0gjP0g8A2T8S2buOQ0nVYtJfixepVmx+HuMiUpUqKJ5CL4p0WvmoPRUC7ZAf62+wu6eEsqXExXGo+mgYJC8/h4bbfaEYV6qWfMjD00scO644VLMeyO4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3748be0ae92so25812155ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 15:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717366759; x=1717971559;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
        b=BXsusXfstMqo2ullegWfeL7Tjl6n9LbHusCLkEN1bMzCzbv1J2ajwhVeoLfoDGvvFv
         wIh6lWEl6RjC1tMqs5IEe8UE8gKBJvH9cj7XWvS0LRfhl3HfYeRajycLDH+ahZWXsgrU
         qh9MxE1RS9H7jJm7pp8eLJs2mn5f+dDJp3uFj0r2Vrvov/7qMRmjfP3yLilDfiCtnJI5
         j7ZFxTenZTx4GiQLk4Bar5dGuwAtB6QtNeYAsMK4upJ5+ke0I98xzIkg61lZASm+r9fg
         TLFpObTgmOqTjcIzDUJmUjcGHSBl7+bBJkX72MsYyK/HspVw6vD7vaIkHJ1YCJl9BzwO
         iHiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsc6iguSOeQ+j83/hirRSnbG2elaZMD/g/CgTbOQ2NdXqSMvCm8siYOSrId13PFA7yfHR0uZmPHhTRxKSWWqXPA3l90eC44WEa0XIF
X-Gm-Message-State: AOJu0Yx8O0/dMNJEAzvGKkYaYqv5QUT7xbJKWVWFzCDdcb8rumQS2Xua
	LOrgjjstOTQpmw+sett5AvZvm2MVHjG90HGR4oUNsLmOC6Llo8GTi/4tzPf9lIkdQuqzvJ+pcZj
	9S4LflisHOTUQD9RXBoCOJ51MkcR2EHnPdPSsOAP8oq/W73oNwmmnZJY=
X-Google-Smtp-Source: AGHT+IF94pz2QiRNUNQugKVRXmOZZ4w9OVV2p0rLYKOzOEnR7kZwWSX70iIiwndxnrKbnOosg1ARCAC1MejFPHqJyvVKW89qXlj9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0e:0:b0:374:5315:95de with SMTP id
 e9e14a558f8ab-3748ba1fedbmr7166545ab.6.1717366759692; Sun, 02 Jun 2024
 15:19:19 -0700 (PDT)
Date: Sun, 02 Jun 2024 15:19:19 -0700
In-Reply-To: <000000000000bb370306101a25a7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a931d50619ef9b98@google.com>
Subject: Re: [moderation] KCSAN: data-race in dev_uevent / really_probe (6)
From: syzbot <syzbot+ffa8143439596313a85a@syzkaller.appspotmail.com>
To: a.sangwan@samsung.com, dirk.behme@de.bosch.com, erosca@de.adit-jv.com, 
	eugeniu.rosca@bosch.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, namjae.jeon@samsung.com, rafael@kernel.org, 
	roscaeugeniu@gmail.com, syzkaller-upstream-moderation@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Auto-closing this bug as obsolete.
Crashes did not happen for a while, no reproducer and no activity.

