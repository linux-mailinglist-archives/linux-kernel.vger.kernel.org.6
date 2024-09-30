Return-Path: <linux-kernel+bounces-344541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7996498AB0E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2735B1F236D1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B7D196450;
	Mon, 30 Sep 2024 17:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hmtwNMOG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F58286A1
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 17:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727717079; cv=none; b=ORZk1SfY0tGWk3VFTu67YsomHTuSY+6md9XAnQoJjxfOj7iGJtMGo0dELKQV+iucR+q8XF2MAXDjcGZ0YjfSl6Wu5fgspd0DqJxnOtaO1ZbYW6mq0JRhoVJ4ZtBeXFnIqZHBoxfJBAoQPXdiDJd/2FsZMddbvBedSjyoAq/+3O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727717079; c=relaxed/simple;
	bh=BolYtsI0w27oJm0hSUK/ybbZTbg7JDNiF7yhR32OlO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VW6GtrIfUBXVtYSZ1rmEXjYevX88S21nUhpG9pbAlZoXZoU9IwikYnwzvVtm6U80iLso8sPgnkhuH0EvguhpHDiK8ymIBYSAqoetN5//QY+rExpbOVdPrSTDz3wWwhAl8G4egfUzs9iM0xlkgOGwcvrZu61tVMDaiAloRb9+Sls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hmtwNMOG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727717077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Tm9+U99BoHPZZgfkmyq7/8cg3UOwPJZ9OVw/oJ0v7VU=;
	b=hmtwNMOGzhXemHXggxlvjFU9tB8AM5+/iRmrZrEsPX4HJ3bk15Q37xZo8gukYZOGrSSBIF
	dZysH6JRYFuUGJUIRcfDyhGkjwExHXfxyGpWTzceoNzqzikXxHmUvuJ3XqSe+FbbNQO96a
	bvM7q4uoae4x1PrkruDD3J1CdkOqfwQ=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-Cg-IzF95PYKFp38iJAcCpw-1; Mon, 30 Sep 2024 13:24:35 -0400
X-MC-Unique: Cg-IzF95PYKFp38iJAcCpw-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5e1c8fa5032so3631512eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 10:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727717075; x=1728321875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tm9+U99BoHPZZgfkmyq7/8cg3UOwPJZ9OVw/oJ0v7VU=;
        b=P7NubdZM/Vo7FcpyzvLP0MfO5Qcfmr2KXWrA19RfVRDk1tbmJfFRC+w9CCODxVK8yN
         LlgRJw7/LwRGtdCOIR6CKdWAPdI6BgLRWpZWRUi/VQR1xRTsRHyze3VzEEiM+lP3eHSZ
         nRxnMYn9vt9ImyvRjBUFA5fTMvLlHF6chYUyOWN6ZwBedDLDflToGrjIM0nS45+7oUgQ
         BiuegX1Ms1bJs1JA0zdonaErnIkHZzWCSPCJM2aiTtPhXJOrwAwiYDeR6yqN4XrrQ2vm
         oZk4IyQqxkyETz0B7wgpyC4mw/tDkRIMxDhLHJ0pOV3FLFSmhHmk5EKM8rWeUqg9oDLi
         a7qw==
X-Forwarded-Encrypted: i=1; AJvYcCXs/0C6lF43D3/GR634nssU3sNBD7d3o2d4PNo04Vg6tnaw9Nmd6YVtE7zCcjIdY0yScNV60CVsrKX8dYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsQGi6sYZ1/v3MisvQuBAvJwSwtbFrLokZSHdONS8MZMFQ45Yw
	n3Py+i9Mzs5ItPTonjPPCUgNb1yyNYvfOxXyU8R3SpetB7KmkrEOBD9+7b9LFe6T799wSardwPC
	wdbhZc7/sBKjA8d0yEuOb0FSKKU5zdyRKXM9aP4e7dCzJzMQ1qtBiDFOBDRZv5g==
X-Received: by 2002:a05:6359:5f8f:b0:1ba:426f:f2c6 with SMTP id e5c5f4694b2df-1becbc9779dmr492828555d.13.1727717075075;
        Mon, 30 Sep 2024 10:24:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxsS7haYLIHqPnAUcqGoVnp3ePyKSCRBSWq3cPAljqcqD8NotPXmxtODb0Y6K/EFfLbKhjkQ==
X-Received: by 2002:a05:6359:5f8f:b0:1ba:426f:f2c6 with SMTP id e5c5f4694b2df-1becbc9779dmr492824955d.13.1727717074738;
        Mon, 30 Sep 2024 10:24:34 -0700 (PDT)
Received: from rhfedora.redhat.com ([71.217.60.247])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae377bc91asm431522785a.25.2024.09.30.10.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 10:24:34 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>,
	Thomas Renninger <trenn@suse.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-pm@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH] pm: cpupower: gitignore: Add compile_commands.json
Date: Mon, 30 Sep 2024 13:22:55 -0400
Message-ID: <20240930172330.7076-1-jwyatt@redhat.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A compile_commands.json file is used by the LSP in tools like VSCode and
Neovim to look up function and type information. The file is specific to
the state of the current system; add it to the gitignore.

Note: the kernel root's gitignore has a similar entry:

/compile_commands.json

I am not sure why they use '/' for a file as it is used for directories.

Signed-off-by: "John B. Wyatt IV" <jwyatt@redhat.com>
Signed-off-by: "John B. Wyatt IV" <sageofredondo@gmail.com>
---
 tools/power/cpupower/.gitignore | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/power/cpupower/.gitignore b/tools/power/cpupower/.gitignore
index 7677329c42a6..5113d5a7aee0 100644
--- a/tools/power/cpupower/.gitignore
+++ b/tools/power/cpupower/.gitignore
@@ -27,3 +27,6 @@ debug/i386/intel_gsic
 debug/i386/powernow-k8-decode
 debug/x86_64/centrino-decode
 debug/x86_64/powernow-k8-decode
+
+# Clang's compilation database file
+compile_commands.json
-- 
2.46.2


