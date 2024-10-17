Return-Path: <linux-kernel+bounces-370468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 842269A2D13
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ED7D1F21872
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD70021D634;
	Thu, 17 Oct 2024 19:01:26 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF0A21D2DE
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 19:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729191686; cv=none; b=QOq5ix+zAQzX7L/w06/mDxxZxElV1zTi50lfgL2ObaK5B6GLRTS/mUJ/TzuJVtuwhoq7tExtRC7Z2+UB28S/P/z0SQpUHsqK21DoaG08BMgh3FE3ZwdMPj6CjuPUatl6jKm4+iPMBCKasBDqDA2etP3GI1GZUsOfkQJlyRHd/2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729191686; c=relaxed/simple;
	bh=wxUGX0Wv3d5Fp83cTipiaVjLrgbCNAlxLwQYDKXlblQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Un5zg4V9cID+utQ0UDpgIGj1dbGH8aeAhtnyf7b9L+uQNWUHK8CX7vWOx8/TZl0nfP/XcGMV0s7tu9M+H1APnDh2lsAGDLGxtQuSM/8NDMDUA02+87+en7sqPkOip1PXyKI4CEYIiCpg+NHlP30ogdHhJKBM5h7zK/YvCOxbtJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83a686237ceso132809139f.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 12:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729191684; x=1729796484;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wxUGX0Wv3d5Fp83cTipiaVjLrgbCNAlxLwQYDKXlblQ=;
        b=ZgQilZY6sLDgUT9vJ7Ck2yTFch8zDosMH56wmxpKWmdJ+Dik8fa39m1KBACM0PJsfd
         NrzSnf9n+4r4Pg51sGIpUGIcCza2i0bYAqsnlGQ+6GkB/6v3y215mwbfMJFVlTjWn1j5
         KZ9USqnXI/loxP5UbXgPFU9jrmj8CC7dPuGJwXLgFHi4Qb2k3PZkGfOqE1TNLPmnjve0
         t0w3NxhKwBn+0QjNczaza3V5fSbwWksH2m4Do4o8hZDMqVzGxRakKXUguXOKBqjeyIb0
         CjjVGaypXerdx1yFc8gzedGGGtxRzjayBwuEfnT2H+VM15/ujrK9M9PT6JI8Z/Z4DEgk
         Npxw==
X-Gm-Message-State: AOJu0YzFdh5szX2Y0vlkLpsHFXaHzO9/cqngDGTMNq2JtUjwMOKq3W42
	8LSp3tQ98PKdS8+e2OzM1P/uR12Qc0z8rhe3qpA4FbFQSH6Dl/rOb+YrpALe9RHTaK0OlNYUSp1
	TCMwZEBcFDX8pBD+AwccNb6fMTtlEXr/jP55hzwDVmBaIPNVIlloD0hk=
X-Google-Smtp-Source: AGHT+IFRXvUeySb+TThWhHw1Q/B8F86gUPehB42FbR78cytSzAW+WUt1Ljxr2aMzP1xDSJeq6qLPH/1zy7QHeWQeglHkPbigk5nv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c8b:b0:3a3:9471:8967 with SMTP id
 e9e14a558f8ab-3a3b5f9fca7mr242875435ab.11.1729191684023; Thu, 17 Oct 2024
 12:01:24 -0700 (PDT)
Date: Thu, 17 Oct 2024 12:01:24 -0700
In-Reply-To: <66f057eb.050a0220.a27de.0004.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67115f04.050a0220.1e4b4d.0003.GAE@google.com>
Subject: Re: [syzbot] KMSAN: kernel-infoleak debug statements
From: syzbot <syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: kernel-infoleak debug statements
Author: danielyangkang@gmail.com

#syz test

