Return-Path: <linux-kernel+bounces-190432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D724A8CFE26
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68B7F1F23246
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3705613B583;
	Mon, 27 May 2024 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmPMN4Z7"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA9E79E1;
	Mon, 27 May 2024 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716805829; cv=none; b=lNmA/JK+4tqdYB4Ym7g3vJTvT78Zcv+Y2iO6I3M01aLCQ7w8ElZhshi+40MDZYlpY/WOgErITD4Q4qLvQcGml9QZYVukdyesYyDSk10OuUKkmOY+gOLueCfNw/CLuplT06unSFXD4pNLUNrVPJ6wYuoOT+ezR8zXxqAu9w8sM6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716805829; c=relaxed/simple;
	bh=Wq8c0gvjGwwSH+T9v3NISONmcgDc06858d/bCXTl+OI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Qn8ELhz7JiMhEYFqeVVhOg8SdvG8t2DxqiPMKt6QcPVLiGmxHp/8Z+epaLiYiGfKTOAzqwYzwVpc2e01IfpnMPb6DCWObCPFSmq7pTtCn+SEQwe3xV1QU8Fj+iRhFN4J80/NErXREQNPUIP2VX3fDRSSJPXSc0NOd95DOWBjhZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmPMN4Z7; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-24ca079af98so1740899fac.3;
        Mon, 27 May 2024 03:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716805826; x=1717410626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNrP81aLFZY/yKeyxhffe6d/lACVAXrZvHzkDRJWq/M=;
        b=NmPMN4Z7317mZuhPDG3J02ZX8BSOdgt5pTvaqc+4u6X20bsgJk4MAX0LU3vHITp9TE
         hoLJYhpQth1bscwMCetHsY87Wj5IOUIlGpg+gjveFSUU/6PGcMIyE3PJDrVI3hsW1CC9
         o65S3Jq+B2Y+3dpcdw6sdMwbzoD+P5+am9OV8ObzFg6jyqlvF/w+e52EEIBNrUceGvZA
         4zzUTi/Y/7ExAVmmbv8EvwKYbiqSvIz+bQotPYP8t+Bhx9UHiieqOcRCvof42Rhdu7wH
         i6IaNB8DYsZzzberuFtyohBxJKR9shQNi2UGNVBNhEpEhvJ8HAVk4FnCbsNlOkH/ym4S
         hYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716805826; x=1717410626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZNrP81aLFZY/yKeyxhffe6d/lACVAXrZvHzkDRJWq/M=;
        b=vRnoAclOuXLdM6e0bbuT4K42TwSrap2mzHCIaQy95Wkj7NPe2Ej7JYA6DX47xrm7ol
         7h0Be5kC/lCwUbfILLCp5lRp32Xs4/hvRrAPfqAmREUopGXPRKvsy+t6mfioOBXv6UnX
         jA+WJnBZjx1BAjBnQaYwmzox/PnTb6PwIZ+4Z8vOQLo6RAVtd4tFgdIXRB+PX33555EE
         ju5Dc0pbdJQOE6uWDjNB0AHrSRRxQl184S2j2DQHTNbsZf6aB2vSVuqvKfEhCBS5HHiM
         wzaP6yJ1RMCkH6G83rTu3xQadqYB+onWpgKXzlxjGUz7rgODzAhtz/p8tbq1+ouRCEGj
         UbgA==
X-Forwarded-Encrypted: i=1; AJvYcCVfqn2+wEXO8IpPcTCQURFte/Ax0BvpQWX8G+b4eBQDpUF46rzXu/Uz9SvOg1tWADcqUDkqQqCZCZofgE5ocJ4ePz0iEBxU6/O+VJRuikOurmMboA9S1D8IXWjxYak9lD3XD2BDpt4BkkWNbhvJUB9ku6xxRpO1EgTRTIa5JTwu8vpo
X-Gm-Message-State: AOJu0YwR1tfu9P++XL4ikMNKEczdKAU2G60hre/+oY1/LgWpkgEUapZ4
	2v/m8RGK+3aPjzddKnbhSak9jNBGxodonrf1wlQ+qf3bLwXKLuLH
X-Google-Smtp-Source: AGHT+IES0E2ywnPldmjeCTxfJ7NVU+l9hbdvDhAfceWO0tztB1xokVuOqYjcZto73JekUsR/4tOuQg==
X-Received: by 2002:a05:6870:55c6:b0:24f:cf39:9684 with SMTP id 586e51a60fabf-24fcf39bc56mr5814339fac.3.1716805825462;
        Mon, 27 May 2024 03:30:25 -0700 (PDT)
Received: from paran-QEMU-Virtual-Machine.. ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fd4da8f6sm4640815b3a.210.2024.05.27.03.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 03:30:25 -0700 (PDT)
From: yskelg@gmail.com
To: Jonathan Corbet <corbet@lwn.net>
Cc: skhan@linuxfoundation.org,
	Jinwoo Park <pmnxis@gmail.com>,
	Austin Kim <austindh.kim@gmail.com>,
	shjy180909@gmail.com,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Yunseong Kim <yskelg@gmail.com>
Subject: [PATCH v3] Documentation: cve Korean translation
Date: Mon, 27 May 2024 19:30:04 +0900
Message-Id: <20240527103003.29318-1-yskelg@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Yunseong Kim <yskelg@gmail.com>

This is a Documentation/process/cve korean version.

Reviewed-by: Jinwoo Park <pmnxis@gmail.com>
Signed-off-by: Yunseong Kim <yskelg@gmail.com>
---
 .../translations/ko_KR/process/cve.rst        | 108 ++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 Documentation/translations/ko_KR/process/cve.rst

diff --git a/Documentation/translations/ko_KR/process/cve.rst b/Documentation/translations/ko_KR/process/cve.rst
new file mode 100644
index 000000000000..9daacba8d445
--- /dev/null
+++ b/Documentation/translations/ko_KR/process/cve.rst
@@ -0,0 +1,108 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+:원문: Documentation/process/cve.rst
+:역자: 김윤성 <yskelg@gmail.com>
+:감수: 박진우 <pmnxis@gmail.com>
+
+==========
+CVE 항목들
+==========
+
+공통 취약점 및 노출(CVE®) 번호는 공개적으로 발표된 보안 취약점을 식별, 정의 및
+목록화하기 위한 명확한 방법으로 개발되었습니다. 시간이 지남에 따라 커널
+프로젝트와 관련하여서는 그 유용성이 감소했으며, CVE 번호는 부적절한 방식과
+부적절한 이유로 할당되는 경우가 매우 많았습니다. 이로 인하여 커널 개발
+커뮤니티에서는 이를 기피하는 경향이 있었습니다. 그러나 커널 커뮤니티 외부의
+개인과 회사가 CVE 및 기타 형태의 보안 식별자를 할당하라는 지속적인 압박과
+지속적인 남용이 결합되면서 커널 커뮤니티가 이러한 할당에 대한 통제권을 가져야
+한다는 것이 분명해졌습니다.
+
+Linux 커널 개발자 팀은 잠재적인 Linux 커널 보안 문제에 대해 CVE를 할당할 수
+있는 권한이 있습니다. 여기서 할당은 :doc:`일반 Linux 커널 보안 버그 보고
+절차<../process/security-bugs>`와는 별개입니다.
+
+Linux 커널에 할당된 모든 CVE 목록은
+https://lore.kernel.org/linux-cve-announce/ 에 있는 Linux-CVE 메일링 리스트의
+아카이브에서 확인할 수 있습니다. 할당된 CVE에 대한 알림을 받으려면 다음의
+메일링 리스트를 `구독
+<https://subspace.kernel.org/subscribing.html>`_ 하세요.
+
+절차
+====
+
+일반적인 안정 릴리스 절차의 일부로, 잠재적으로 보안 문제가 될 수 있는 커널
+변경 사항은 CVE 번호 할당을 담당하는 개발자가 식별하여 CVE 번호를 자동으로
+할당합니다. 이러한 할당은 linux-cve-announce 메일링 리스트에 공지사항으로
+수시로 게시됩니다.
+
+리눅스 커널이 시스템에 있는 계층으로 인해 거의 모든 버그가 커널의 보안을
+손상시키는 데 악용될 수 있지만 버그가 수정되면 악용 가능성이 명확하게 드러나지
+않는 경우가 많습니다. 이 때문에 CVE 할당 팀은 지나치게 조심스럽게 버그 수정이
+확인되는 모든 버그에 CVE 번호를 할당합니다.
+이것이 리눅스 커널 팀에서 발행하는 겉으로 보기에 많은 수의 CVE를 설명합니다.
+
+사용자가 CVE를 지정해야 한다고 생각하는 특정 수정 사항을 CVE 할당 팀이 놓친
+경우에는 <cve@kernel.org>로 이메일을 보내 주시면 커널 CVE 할당 팀에서 함께
+작업할 것입니다. 이 별칭은 이미 릴리스된 커널 트리에 있는 수정 사항에 대한
+CVE 할당 전용이므로 잠재적인 보안 문제는 이 별칭으로 보내서는 안 됩니다.
+수정되지 않은 보안 문제를 발견했다고 생각되면 :doc:`일반 Linux 커널 보안
+버그 보고 절차<../process/security-bugs>`를 따르세요.
+
+Linux 커널에서 수정되지 않은 보안 이슈에 대해서는 CVE가 자동으로 할당되지
+않으며, 수정이 제공되고 안정적인 커널 트리에 적용된 후에만 자동으로 할당되며,
+기존 수정의 git 커밋 ID로 추적할 수 있습니다. 커밋으로 문제가 해결되기 전에
+CVE를 할당받고자 하는 사람은 커널 CVE 할당 팀<cve@kernel.org>에 문의하여
+예약된 식별자 항목들에서 식별자를 할당받으시기 바랍니다.
+
+현재 Stable/LTS 커널 팀에서 적극적으로 지원하지 않는 커널 버전에서 발견된
+문제에 대해서는 CVE가 할당되지 않습니다.
+현재 지원되는 커널 브랜치 목록은 https://kernel.org/releases.html 에서 확인할
+수 있습니다.
+
+할당된 CVE 항목들의 분쟁
+=========================
+
+특정 커널 변경에 대해 할당된 CVE에 대해 이의를 제기하거나 수정할 권한은
+전적으로 영향을 받는 관련 하위 시스템의 유지 관리자에게 있습니다.
+이 원칙은 취약점 보고에 있어 높은 수준의 정확성과 책임성을 보장합니다.
+하위 시스템에 대한 깊은 전문 지식과 친밀한 지식을 갖춘 사람만이 보고된
+취약점의 유효성과 범위를 효과적으로 평가하고 적절한 CVE 지정을 결정할 수
+있습니다. 이 지정된 기관 외부에서 CVE를 수정하거나 이의를 제기하려는 시도는
+혼란, 부정확한 보고, 궁극적으로 시스템 손상으로 이어질 수 있습니다.
+
+잘못된 CVE 항목들
+=================
+
+특정 배포판에서 변경된 사항 적용한 배포판은 더 이상 kernel.org 지원 릴리스가
+아닌 커널 버전을 지원합니다. 때문에 Linux 배포판에서만 지원되는 Linux 커널에서
+보안 문제가 발견되는 경우 Linux 커널 CVE 팀에서 CVE를 할당할 수 없습니다.
+변경된 사항을 적용한 특정 Linux 배포판 자체에 요청해야 합니다.
+
+커널 할당 CVE 팀이 아닌 다른 그룹에서 적극적으로 지원되는 커널 버전에 대해
+Linux 커널에 대해 할당된 CVE는 유효한 CVE로 취급해서는 안 됩니다.
+CNA 수정 절차를 통해 특정 배포판에서 적용한 항목을 무효화할 수 있도록
+커널 CVE 할당 팀<cve@kernel.org>으로 알려주시기 바랍니다.
+
+특정 CVE의 적용 가능성
+======================
+
+Linux 커널은 외부 사용자가 다양한 방법으로 접근하거나 전혀 접근하지 않는
+등 다양한 방식으로 사용될 수 있으므로 특정 CVE의 적용 여부는 Linux 사용자가
+결정할 사항이며 CVE 할당 팀의 권한이 아닙니다. 특정 CVE의 적용 가능성을
+판단하기 위해 우리에게 문의하지 마시기 바랍니다.
+
+또한 소스 트리가 매우 방대하고 어떤 시스템도 소스 트리의 작은 하위 집합만
+사용하므로 Linux 사용자는 할당된 많은 수의 CVE가 자신의 시스템과 관련이 없다는
+사실을 알고 인지해야 합니다.
+
+즉, 우리는 사용자의 사용 사례를 알지 못하며 사용자가 커널의 어떤 부분을
+사용하는지 알 수 없으므로 특정 CVE가 사용자의 시스템과 관련이 있는지 판단할 수
+있는 방법이 없습니다.
+
+항상 그렇듯이 커널 변경 사항은 개별적으로 선별된 변경 사항이 아니라 많은
+커뮤니티 구성원이 통합된 전체에서 함께 테스트하는 것이므로 릴리스된 모든 커널
+변경 사항을 적용하는 것이 가장 좋습니다. 또한 많은 버그의 경우 전체 문제에
+대한 해결책은 단일 변경 사항이 아니라 여러 수정 사항을 모아놓고 보아야 찾을 수
+있다는 점에 유의하세요. 이상적으로는 모든 문제에 대한 모든 수정 사항에 CVE가
+할당되지만, 때로는 수정 사항을 발견하지 못하는 경우가 있으므로 CVE가 할당되지
+않은 일부 변경 사항이 관련성이 있을 수 있다고 가정합니다.
-- 
2.34.1


