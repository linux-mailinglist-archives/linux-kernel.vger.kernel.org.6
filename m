Return-Path: <linux-kernel+bounces-333579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D25C797CAEA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE5CEB226A0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 14:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E6A19E83E;
	Thu, 19 Sep 2024 14:24:27 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7EA19B59D
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 14:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726755866; cv=none; b=arVn8bHO79dorgs8HbrgFbciLUrx/35nhq36ImftNEhlSg267lXcdJb3uCuDTkMFFt3DwtI/Ig3Aei9QIdiB+zgBrGtqjN731mZmo/Wlo71rbW44fjvISOPbAmF8lHYwIQbkBKB69v1RYU3ohTNf/v+cQjR9ogXQDOCrIaiDkVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726755866; c=relaxed/simple;
	bh=ZuDa8PgCetHZz3azjtXB+wao/HQzxIr2s70KrXIXXdQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cQ5pIXXGW1e1yNvHilw0LVEf+4rTmIMNPR4DJh/yK4voCC9eGRYccmAmHDcuZleIdSIRdvYNqUSxv4RVNm6Gd4xOXNvLhg/CwaaXr/SxsPfI0JwUT59av+9rAdJ+oVGlKwMIIJOEAqR+/230AAA2jcFCybEesogZ8mKgGjbcpuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a049f9738fso11304055ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 07:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726755864; x=1727360664;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuDa8PgCetHZz3azjtXB+wao/HQzxIr2s70KrXIXXdQ=;
        b=pNc8XjRdXkVo4r3WfNU3FpCTDwsfqjf6AlerdRZVxV6x/FO5eWQ+f9vShE/4AkDOvA
         ME+zN/LrevUCaZ/eeYYXYuoq6sFG+10ZOKwsP5HEIwMoqmulIaoWc0pOW3stk54ncIyR
         +nu6W1hDjr1nQWMx0SNj5bjwUtX7usPEPytJgRm/9reXHadb6ndDqwBXY5LTtyJuPjmE
         wUeyp2fl6qZ66xXPvZUxiuh+iaBR0MHWj6ZDRxpKb2XN2XLL3YbNf0bV02WBq4nuL59B
         JxTSijelwP6yK3eA7Q4in7PHcXRZgI5EPFW+y5Fh3+OlNq/XRRY4lCGGlQSrm5kaHoFF
         lYuA==
X-Gm-Message-State: AOJu0Yw/9k+FmS9xC6jY0SuZV3csRAEVISnd910rMvZg8u+JyVgPI4NK
	PJyA721QyNrsymrmXDXtkCIpqrG/wn6P52iOpB9GWO9O1kcQrQl5yyzmHG0YtjtAh2/ORb51cPm
	/FY4bBzH+dyP/SqczMXyBUdcwTUoFde3CbpuSpeQxFS1cuqhkxzee+lc=
X-Google-Smtp-Source: AGHT+IHmobSYaSvqmwaMTWxAIMCAeB6q+bXkASJEMchPl07BpiHzcM9KLNqG36erTNdbVe4JDxcrQKGK4OUXkHgAtVbzlTxuOsAl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1cad:b0:3a0:9fc6:5437 with SMTP id
 e9e14a558f8ab-3a09fc656cfmr139382635ab.18.1726755864461; Thu, 19 Sep 2024
 07:24:24 -0700 (PDT)
Date: Thu, 19 Sep 2024 07:24:24 -0700
In-Reply-To: <000000000000e28810061fb68dd0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ec3418.050a0220.29194.002a.GAE@google.com>
Subject: Re: [syzbot] possible deadlock in ocfs2_get_system_file_inode
From: syzbot <syzbot+e0055ea09f1f5e6fabdd@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: possible deadlock in ocfs2_get_system_file_inode
Author: pvmohammedanees2003@gmail.com

#syz test

