Return-Path: <linux-kernel+bounces-403763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EBB9C3A70
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BA811F21FE9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204FE16A959;
	Mon, 11 Nov 2024 09:09:31 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A63561FE9
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731316170; cv=none; b=HGRybQ9OM2n5kx/lRFzS5kGKo8MxcYTIstXvqprQt7ChxLjtJfbpmD54iwh3MaftUK2s2LfHILBqVL2oajl//KGv5fG36zPZYWDHRl9Ie3bQPoDpkWsgq/zOhtiiWwoA4KPvkO7ZNeJgCfoK2S3dmL9dl6Y9Plk5nOHPG2hzc3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731316170; c=relaxed/simple;
	bh=fJkde29QPQ3u0WzU39PBsqz6RfUjXar8wOSpoTPh+pQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sqf1S54y1zULSUMo/428p201F2/zviU7cHImPYmnaUdOfrlMWWex6MPSAvsLlhze3P5ApB3VBdQC+07LRApxXji0IJ1Vf71OQFmGg6Z6VEi+1pWlzz0FnfDI2utg2+jmrAQGrf+oKlnFV5Nv6JOwvZp5aDqC4pZtC6Lud6fKsr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c5a6c5e1so57523145ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 01:09:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731316168; x=1731920968;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fJkde29QPQ3u0WzU39PBsqz6RfUjXar8wOSpoTPh+pQ=;
        b=K05j5r/zFlL7UZ7Q3Jj9utzOonCUOt2RI6g70rhbYBe3xY+8Ds3b2y9nQy37tq59Dg
         OQKpjfUAnTLoIR8c7G7zIHOQD09rDI7yTzBhuv4b6ZLfaR9vw8kxriciZW4MsSbiMiGp
         qdajL7rQGlbpQJt1ggb5zc44HzQ+q3ylx0HqF4TNFyLEvDsBWyyXHkBi3rNXPOlS2knI
         oB6btLP4LD1T19xNtOYn5AH6/6pnBiLaNwF1gvaoLOMt6tuAMlp3PrrPb0yBMXFleYko
         c6iu/B2nMpcRP7haTZGFztbeYBS8UsW9UCADMsyIt9KpJq1st5BYApJKRucBhEtugs28
         RxuQ==
X-Gm-Message-State: AOJu0YyOddl3EB1L3cnUzU4DS1pLCwNz02HiY5VQCRqbewpMgd42oaVp
	RXJ9XLLtlUEz/0YIaEaCix99FNxMMnbTCiIBQqk+o0tn/8KEdnlPEz1O0uvGwjPva0cXT18Go1+
	Dvunrj9W6aB6GLJiVmt3zPAWkLBdwz0wn4EmU+gOgBNzQT949NEYI7zs=
X-Google-Smtp-Source: AGHT+IGGJ3DjfZdQHPSQl4uQWhpFxdf++aONoh8LzXxw6RKZ0mGP43V3ApWZWefkr/F2WS1o5qKkrjD1b/Wz4C8OXFEalQbPOe72
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24c:0:b0:3a0:5642:c78 with SMTP id
 e9e14a558f8ab-3a6f1a2f364mr130234335ab.15.1731316168414; Mon, 11 Nov 2024
 01:09:28 -0800 (PST)
Date: Mon, 11 Nov 2024 01:09:28 -0800
In-Reply-To: <67314fa8.050a0220.138bd5.0057.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6731c9c8.050a0220.138bd5.0060.GAE@google.com>
Subject: Re: [syzbot] KMSAN: uninit-value in bch2_btree_node_check_topology
From: syzbot <syzbot+494bcd3631a9f6759f91@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: uninit-value in bch2_btree_node_check_topology
Author: gianf.trad@gmail.com

#syz test

