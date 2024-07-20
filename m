Return-Path: <linux-kernel+bounces-257851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7474B937FC0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 09:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309FE282250
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 07:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C5142076;
	Sat, 20 Jul 2024 07:44:00 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEA53D0D0
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 07:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721461440; cv=none; b=aDXsbMa2AKK6rXZKrfR4StHzBqLQgogz4j1Bs6RGNa7TsJgSYRrf6olixKfVoRY83DCv074ocFJ/CxMKjDwJdK7EH1nrpHQLhXwO2KAv8HHcgUGKvduzuS5CtxL7sguJinYy9dPchPf/NGKnWRXJn2yYB/57Jg9B5pvX0MAR7v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721461440; c=relaxed/simple;
	bh=xJghMIDSFZMQwcT/bSxKpvABpwSoalmPwzGjPqwQMIM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mxfR4oixlxfU1D7klQy3pUwp0QZva6oqdyluUp9lzRjdGdiljTgdsoiBprJBxNdPYtewWunXQhzEy9YqJFtAJ4+tT3LYCPldb9JtVlRo/507RdbJOCa/WKgQRLfX2KCiqQPjrKVT2qVa+3AKshjPcuhqy+ra9amdjpmHCfwJFzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8048edd8993so380900739f.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 00:43:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721461438; x=1722066238;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X0Nn3s13nczj2fIBPcpMuDTEigrtwN2HthLoUAG4F7w=;
        b=lREwSZJDJj4IeB4HrUP3ItUYNUVfT4BbLCmvapf5v5ALp7GRCPhHF7ItYI7wxdJBxM
         cenW/xKksIsBbmYZ3h36aJhPMO+e/VimVdL40HVyXBW596/Bh+mhyRmxzCBOH4mZdv+V
         MPbV5rkssUYnglhAaRQlxb154XfeZSl0crIHcANbQi1WmFsvdfXQzHDFJX6/5231/vTq
         znK+6cRcFzWFGFOagc4p/SneCqCPTidQN7foXzKzIVFdQFs4STg59JGpE8ZB8eKy/3Gs
         jSjDGUOiPu2GDKmdQ4PUexhvdJmATKHNA7gYlmmjRUehWVqFs4SIR6U+PAEQnbhb/HTI
         a6Gg==
X-Gm-Message-State: AOJu0YwS56vdvJcBaVNmBdSn5rxqs0TzapbmEIg7acfEOxzPeChJFjlz
	pfKiyR9QK87wNvKMizV+9vRVcVtw+SDZmK42hPQJ8yUTGCwr1tpjCttrObVapqkQcEZ+565w4SH
	62QWX9ZWc4gEwHNEe9ezqmTumKm9KTnwW9pkOrHF1igqXvIufXdB/F+A=
X-Google-Smtp-Source: AGHT+IHewp7o2Cyj4Jb3LKFHiPRwlHXXQTofxPTAUwzt8iA1+uL6DIAMKXxDxr40Fa3V2/gW8YY2pS6h6WsxcFEKtK2dZbQRntDh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:138c:b0:397:5d37:61fa with SMTP id
 e9e14a558f8ab-398e4bcd071mr1535995ab.2.1721461438052; Sat, 20 Jul 2024
 00:43:58 -0700 (PDT)
Date: Sat, 20 Jul 2024 00:43:58 -0700
In-Reply-To: <0000000000000fc50405eb48a1be@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000828f3c061da8f900@google.com>
Subject: Re: [syzbot] possible fix
From: syzbot <syzbot+c300ab283ba3bc072439@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: possible fix
Author: almaz.alexandrovich@paragon-software.com

#syz test: https://github.com/Paragon-Software-Group/linux-ntfs3.git 
d57431c6f511bf020e474026d9f3123d7bfbea8c








