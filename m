Return-Path: <linux-kernel+bounces-299247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E0295D1F4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24C01F22D14
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821981885BE;
	Fri, 23 Aug 2024 15:46:46 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB292186E33
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724428006; cv=none; b=pf4KGtMDiX+yZq0ZR99CvDCogrj1PL5RMMVPbM/WfzOR9rmCiLJ/SS4c1VtsjRBngcVID4m/0tX1oOV+zHbKCYtPFBlVk4GmJLdBij0os7gN/JEtgh3J1kP4ARdiEMVgNIGq0SOwJAo5Yzajqr6ffbRK55vJndYj626x0i67mOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724428006; c=relaxed/simple;
	bh=UhC5ISVNW0c95Dp8v4Y5XXSGKXsDIbg+03MjLXbTZug=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=f2TKJHZ7lt6x+ETilPsfFo6d5sNSBardrTiOHGN6yd/1UA2oZMa1LgsTWAX4VuUhSXCzRMsos/CYHy88vohLndQ4eHH2L+9fxVJDN9dN2IlvaVyP3V6qKUxsEQxfOOQ4S6k2tJyknjcCkp+LBdnJ51aHQQL9XNZp1QMA5ce0Fs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8278114d3a5so146956539f.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:46:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724428004; x=1725032804;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhC5ISVNW0c95Dp8v4Y5XXSGKXsDIbg+03MjLXbTZug=;
        b=L1cBUK+QhkXSI2mnAgulwrehTk63aNIMhervc4Fw+8EMhlOk7oHU+3rV92qxrXyrjD
         DPwLaFAsDqt8z9WANMhAJQhEFJMTKjV0y7kqVo3ppu7STUGEOPNS4cWQZR4E2VkdvXuf
         k8MvMvkjs7WlqSw5Wpq0LJ1OIAuGH020n/4ga7/w2LJPAQxKKgh/ne033iAnYL8BGswB
         ECTI6RynZev+h3TZSx2BgQERdqNKWh3Ci7IX9K3+xOYAgBsxVPa47i7cW9txFbPb5yX0
         eO5jkebmfuxU/C3/GynAuggBL1M4sx6KWY2up3SERho6jZxQCqLIEpW2uoV4JC9uaGM3
         FXqA==
X-Forwarded-Encrypted: i=1; AJvYcCWBXPye5sfkIhfTCPNPuc7/mAtimQGJi/2VN/JqguoqYlCRpvd06DXz28qQrf9R7KxmxlchhLdPhHmHtZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YztiSiNz8MGcCjGwCLmwuM+AflPcXaVH/dMGjpVtNPFLs4MUNr/
	LT2Ad4s5e3tYTDuwjSmoXuMayaOY58eiP+79D14jOio3iKeShdtGpK9bB7Lkn02MfXFHTz9WUwx
	N7jrwDeffohjay2l/k4O2FGceVIm/25uh6Y3tgcNcxRJFzc2ZuiWXW0M=
X-Google-Smtp-Source: AGHT+IE+YaV98yRG9iRgRA+r6uUJT1AuGmrDH+b0rh8D7UaUTLiBwPtzXJyxOlFcLrhfO66OmH1kgyCeQbxD0Sol+Y46uK5+q2Q/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:640d:b0:809:b914:a53a with SMTP id
 ca18e2360f4ac-8278712e0e1mr3031439f.0.1724428003848; Fri, 23 Aug 2024
 08:46:43 -0700 (PDT)
Date: Fri, 23 Aug 2024 08:46:43 -0700
In-Reply-To: <6558be8b3fb44cc8ad24a83b12d7d3a9@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009c481b06205bae41@google.com>
Subject: Re: possible deadlock in attr_data_get_block
From: syzbot <syzbot+36bb70085ef6edc2ebb9@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com
Cc: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test:https://github.com/Paragon-Software-Group/linux-ntfs3.git master

unknown command "test:https://github.com/Paragon-Software-Group/linux-ntfs3.git"

>

