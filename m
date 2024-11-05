Return-Path: <linux-kernel+bounces-396397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB569BCC99
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C51CE1F23A54
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84B41D5146;
	Tue,  5 Nov 2024 12:20:20 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60B71D432F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 12:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730809220; cv=none; b=tL48QpO/Whcp01DPuY5eBorRanFFj+O+ElUpBT5staGnp/H+mCbnszoxWTNuqQL7Tcr2LmXYXuhHiz9VYZkf0T067yy9QwxciZAh7A8neqXc5bXRaVLne/Nz2YhXz2l2K/XK30u+2s57knVW63yUGLM0e2wCP3zPR9yLbj4Ji2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730809220; c=relaxed/simple;
	bh=t8a2/cCE1oflSLCaIQ27+8U51A0RiEFOLegdvq+mp8w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=M8Q14suHiprDmInb/WzX7/OfcnMZejIAB7iksHWs2idOmvvgAApbmwFpnyNA6R/9XPck5NgZ2vrCllW0te7erja7cPS1ZoLREg58wm16nXJ7y34/Ei3ETPu0Ucx1Z+8Q9MrY5MRmR8+fEFgcqoz3vZsMfAH/YYPk/RE7TPBwBRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6c48f1312so33591015ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 04:20:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730809218; x=1731414018;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t8a2/cCE1oflSLCaIQ27+8U51A0RiEFOLegdvq+mp8w=;
        b=tSwN7K56Q2bSLtvG2n5dG7xY+mGkeBBsn8+Ij9A6C+TeaU0oGCg6ihQFkUpI4FTxmL
         KIb/OWjonxyD7rthOA0J6wpHVbuWIg5TfEIfLTF6ZXyrBj8ZbyHaAmtz6qSwBDsJPJUc
         vGGdqeYoy45cNqkRXQV9kVe2mDKJEaDtN9WqrCQR/dKiSpsdS+mM5s6goGCMRnLwkCty
         ZeDX/YH/QQT5KySYUsWdF5eIwGPAbMwqEURWveI04xtFhFZgbFKYiyo2dSPuYrV+sLsV
         //zTOstv7Le6q2NhjWVQlOTN7IKSaqTJNlS7T3EB6JuAgxqZWVANkpz08vpVpKEkD4hh
         yhlQ==
X-Gm-Message-State: AOJu0YwKdWYzwG6oBOOSzUGeJVAQeQevSjjxEQZz2NGItdUJl8lsDUKT
	mIyecG/x58M1s0C4oPt6dAz+17ybsd2k1BioCc9DaqawvJiopgxd+IkB171AyU1UH/6DXBjAktc
	mjSwuyLbB3gOTx1vZ9zixwCBWHY+rl97ULW6WQqVJyOsI9sZ2e68atZ0=
X-Google-Smtp-Source: AGHT+IFntMryJS/AeCVwogJ/EH8ldj0PMjzDImjNcAy9XAEBlDj++RXdCkQpwoUOZZ6E0HUVtLEB0d89rN3+wMvQfP3UswtfBXFn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b09:b0:3a6:afae:752e with SMTP id
 e9e14a558f8ab-3a6afae7784mr161858645ab.16.1730809217820; Tue, 05 Nov 2024
 04:20:17 -0800 (PST)
Date: Tue, 05 Nov 2024 04:20:17 -0800
In-Reply-To: <66fbc081.050a0220.6bad9.0056.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672a0d81.050a0220.701a.001c.GAE@google.com>
Subject: Re: [syzbot] KMSAN: uninit-value in __hfs_ext_cache_extent (2) Inbox
From: syzbot <syzbot+d395b0c369e492a17530@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: uninit-value in __hfs_ext_cache_extent (2) Inbox
Author: sarvesh20123@gmail.com

#syz test

