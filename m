Return-Path: <linux-kernel+bounces-364814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 607FA99D9C6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 00:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7C2B281F7B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1251591EA;
	Mon, 14 Oct 2024 22:25:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1B02BD19
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 22:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728944706; cv=none; b=iHFA56R3tNrBzs4FiEWPuJrnm+bePa3z4dQSlc4PmqFdLTcWUDQf4wNFIGcCP7OX46XwBn3zX26uQL0hmwxo49RN25ISTvDuWYVx4QGbDt5iSFpg9aSwvPjwMP/XqIsjiwURT+OoDakXntKg8Z7/rOBAhHILTCNfzUMpy3xUeqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728944706; c=relaxed/simple;
	bh=v+agA1GzMbSPyko2lfKWPfx4t+1C0NQ1LVVBokmMLiI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eGmjDt1tpoFeg0Zqf5wkuYZMojHEQUuawnZtM1UHD223iX5z5J8uGrOaOjo9g28WWS3AdiUM0shAJWOBiq/GMU4kawZYMeiKFDhM+0pQyJZcLtL7S6aqH/spUiEl7UXTgtERQGtIbvCQvZG36fVmOY3rzGXKFXATbl0LzDw6GH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3b506c87cso31383775ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 15:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728944704; x=1729549504;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v+agA1GzMbSPyko2lfKWPfx4t+1C0NQ1LVVBokmMLiI=;
        b=g57SsrSZHK8Uk2o2mxkyics5OCcVpVCYnG1zCR+h9EnruWGv48i6Yrpb+k82ezaq+e
         b8z4Ou7yXGj4+vdWS5MayYnbvmKUpshIMWjyKtOu5ntJwkYTSSkQAntBldYzKGuxgP0z
         1gBC6nxlu4/kEzt2SQSCwrSUyc86KfY/DG27srGLME8qBNFIpYCN6uJCcH7MERKDsaV/
         iA1IqTMoIfVekyFD0gbB7YLJ0dHx/S9PG6cBRVCUxdKBUSiwT3a9bOdtNp4f0UBbvQsm
         OniHfMmsa4ADnegU+G2i1WuPzgpkpGmEDcAj+mTemPQo9mdYQUgGKV0j5oZB32+FWXCO
         LsJA==
X-Gm-Message-State: AOJu0YzgMEZZWftMMYDo1dcnRvuVi63fLb8y1HLZ1TYaL1mDBUzXjzqj
	GGaKYyz0fM0UYWijXhO0oTIloz/xuRVogDq3bKLeSTrwzkLqFz3Fd92CqNkWj7BuaSRRqWRYK2Y
	BYk0xg3gzLuqe/dI7iNj6qGg5JrapoAoqBpFIO6D68EwmGxls1IPwsZU=
X-Google-Smtp-Source: AGHT+IGPD3jNMsLVC+jofB51gHQiEHXXRlW7aqEhs332KCHiDB+fJxAyrH7M+lWyibUGfR98CFCn3591VVn0qcXOnqJe0fw+9s88
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c46:b0:3a0:9954:a6fa with SMTP id
 e9e14a558f8ab-3a3b5f54bcamr100004505ab.9.1728944703983; Mon, 14 Oct 2024
 15:25:03 -0700 (PDT)
Date: Mon, 14 Oct 2024 15:25:03 -0700
In-Reply-To: <66f574eb.050a0220.211276.0076.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670d9a3f.050a0220.3798c8.0133.GAE@google.com>
Subject: Re: [syzbot] Re: Fix NULL pointer dereference in read_cache_folio
From: syzbot <syzbot+4089e577072948ac5531@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: Fix NULL pointer dereference in read_cache_folio
Author: gianf.trad@gmail.com

#syz test

