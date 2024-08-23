Return-Path: <linux-kernel+bounces-299246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 584A895D217
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06F50B2A81E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE9C18BBB7;
	Fri, 23 Aug 2024 15:45:49 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C80C18BB86
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724427948; cv=none; b=ba5WdF3hIsNed5QMBnPNy7CGis60dvQ4JuqlOomxy9Wx82VaRVDBMGU2RDwU/357Uv73MGxcZdPbtUl5MZYc+vZBX1b1mribdRM/rA6yhc4JbmuK8pvBtXuDBh3OZhYzKhbnG7IxLclTEIdoG9JOIyeiae/QxjgzYlQPh/4JSwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724427948; c=relaxed/simple;
	bh=UhC5ISVNW0c95Dp8v4Y5XXSGKXsDIbg+03MjLXbTZug=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=GaRsWxK6Ne+Dq87isqNQKTxCXDlC4SynZ98SPSwI9GawhgMjOJHIYLFHhhgYT66mu8xd7NjAH24jObRO8c7Y+niId8hbvGuKvYZ6HNHeHCg1LBaMoj9lHUNeIlyt+GQj53r1XNKvJoLfyKAHzs4KH+3kyP1skhT4u1QMqBcJliY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d52097234so24539315ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724427946; x=1725032746;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhC5ISVNW0c95Dp8v4Y5XXSGKXsDIbg+03MjLXbTZug=;
        b=Tq49bDQbxYgsLyQd4HFvKZihKryJmCqJlLvv00SMCXBfaavnrJJ0r63e+xWAIpP4hN
         MxwaBGyZNg3hIEzxBwpIomKivSLk339maDzFk/Dhn14JskreS/ZK823HVsCXgsaeOaPB
         oyGvw3/zsxFrj+mzHJOCIle40wr2oRdmf8c/8EdQD4e98LkUwdt3oQ5P+zf5i8W2IwC5
         GH0NCr7b1NpL0ezoulXs0uRDUQ5H0pFtdGZ49Mdbr8e87TLF8laTHGl1NvN77MQZ8xT8
         WzD14TpbtHstyMep/CbgBN5k3NgCOY4t1i5IIS6g6EEJibJPgoCRC8NlmcJEp6sV0deT
         cOrw==
X-Forwarded-Encrypted: i=1; AJvYcCW7RfgkbR5LgcD/rOos+hRSdmtzSBsDSeq4+Hqa5MGF/BUguGyUzPh8wfRlsfBvWcPAfMoQ0nDd2Zd1dxA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf+VPR0shQFYJcVCfS4rja+9h+l99qIw9AQKRLSFWYhV78OEuk
	Fr0TbK9b2a0tTFKRnyjcNXrD2W2+4PSfcqQ69OBOMOxNlCcJYae2YJoHkgwQftxu3lQt3OpNhY6
	PE2twLSTxkrO2PRc3vto6ZliERUAi9Nx+AwoVyPSzkhZORTFnoPNCKsU=
X-Google-Smtp-Source: AGHT+IFEZHsmAvk7csTdVtC+zhVGRhBw68um4kIpRvc4X+Ny0f4KfNFAl4LZVsNjRgN3dQPsY/h0EplkXt07wQmGHSkrjXzaXaiC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1523:b0:39d:376b:20e4 with SMTP id
 e9e14a558f8ab-39e3ca01d88mr1773075ab.5.1724427946415; Fri, 23 Aug 2024
 08:45:46 -0700 (PDT)
Date: Fri, 23 Aug 2024 08:45:46 -0700
In-Reply-To: <f923326c8f484e30b05391b463305fe0@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002fec0206205bab01@google.com>
Subject: Re: possible deadlock in ni_fiemap
From: syzbot <syzbot+c300ab283ba3bc072439@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com
Cc: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test:https://github.com/Paragon-Software-Group/linux-ntfs3.git master

unknown command "test:https://github.com/Paragon-Software-Group/linux-ntfs3.git"

>

