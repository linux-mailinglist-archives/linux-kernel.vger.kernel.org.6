Return-Path: <linux-kernel+bounces-199420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4877D8D86FE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1CA81F221A4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8562413213B;
	Mon,  3 Jun 2024 16:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KD/Yp/8v"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C8513667E;
	Mon,  3 Jun 2024 16:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717431375; cv=none; b=opInpXczF8uQVtDapZPIif5UbpfApcSt4qqtF0YNrYDs81/e36TXQ9jxsuGVJoQZAvHEtgktLy25TBywJMCbmYVCNXnC0AZVnYSDLw4FAxTeUQT8WT1A7h+8FPcvj2jqkt7w/VGPXDbuVLWUvEtodCMTmXJtkRKjwBF1WJCchlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717431375; c=relaxed/simple;
	bh=R4zsvxB0y6E49xztUL915eNuzXp/7rBqKhyWGjTfa00=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Fj/tzBV7JnnKGLWeNaBuFoK3YxO86JXfIRY/SEpur761JihTIRfnypKnht6RsyauIQoAqTkUSi9vu8V2kXjeLhk/RE5ZXgTTr/MBJeAJilEntlBQIGF+8pzXKvnoU36FqxhXmloXRW8AvKMNMewJld1wKootyTAduxIcZtXcOrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KD/Yp/8v; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c24115469bso642516a91.0;
        Mon, 03 Jun 2024 09:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717431373; x=1718036173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C/N2SeCGrQ/hc/PUmLOr58aWJUfdAgaipmiw4zP9hpg=;
        b=KD/Yp/8vz5fTaq0CPa5iHZtmF8IA1ZbkRU7EYdoLK0Pj4oMdo7ybAgscxJs58VK78f
         r7DVUy5IM4H7ttAICm7stAadAiZojjG51RiTxTfyduamw/xYgnsqedjnYjzYBBp3ziS6
         1vMfSX1ONpNcN/zRCyC8qPT640PsxMTSVocJDoO3fhWGC0Nnp5AsrpSVc8k3Wyx6QZwN
         KULYm9OC3/Uad3qo+geUeAk4PL0N9YN7az8jfaSmK7xco1MxaJJ9ADnqhPDXVTrNpaBz
         buyI4IXPfmveDAYylU95hPRuQsEsgz6kvNR3WR1uo4oFrFR5Ko6z+l9IfeR7QzbF6FEZ
         SDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717431373; x=1718036173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C/N2SeCGrQ/hc/PUmLOr58aWJUfdAgaipmiw4zP9hpg=;
        b=DwYxHnRPwvahnL3TQ38YU2h7YKngccU/iu3MFiOfP6ST2p1BS3MnoxIsQy4InRik7w
         8/oTBuR9F7+CMZ+EnTs7mrFnOtP4W6ZaPb1cm73DBQ384J8M3FQatQWtgXYlbIfagvYE
         DhOM0O+CmqaOxMjHTuUDhWsBTGerBIQxfI3hSX58lHyGxXLi059aaNPBNMb9Qf+C1oKt
         U52AovvtChyPt4eXj+yKs4PmzBN7+fs+4zmzg4Cn5vewWcGexQfW4kKiI0kPqpSuUSrw
         CMyqI5YHZgUOtfOkVv28IvUpXGtU5dGGQcrw9EUxcdfvNDfS8a7gFSCkOvKcLaN/5e+p
         Rh6w==
X-Forwarded-Encrypted: i=1; AJvYcCVaNG9XrKPwZwjOcfr4GcXsrlag7mWktSalZU1lABcHX8D2OCdudYXLOs4UZu1GMCaOS8gcbqGp0umxwpa30tqm+DqEVKkQES9yJlo75WZqVvEOYKA+twjbz5GdikY+d2lQMYuaHWdmRthSKiLtUDun/7uD9aTmtT3xPNLnJTNAD5+6
X-Gm-Message-State: AOJu0YySTQg7fnY/tLBerG7mJwPpoMem+0z+LbFe4C7uYpPoc2yUEUYe
	bA5MBJvjEkEIAhr4AGtBIWbhkhx7t6cCaDZpFQcIs3y0eTSd//Aovz9LikRhSXU=
X-Google-Smtp-Source: AGHT+IEHgrToHEtFQ4qUID6sHHk78/MMQn6dYkUjZkvRhieZSuneVkSqSXSEEI+/NohsmEaRRVxm8g==
X-Received: by 2002:a17:90a:d142:b0:2a4:79ef:4973 with SMTP id 98e67ed59e1d1-2c253077af4mr166664a91.14.1717431372713;
        Mon, 03 Jun 2024 09:16:12 -0700 (PDT)
Received: from paran-QEMU-Virtual-Machine.. ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1c27e577fsm6415462a91.32.2024.06.03.09.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 09:16:12 -0700 (PDT)
From: yskelg@gmail.com
To: Jonathan Corbet <corbet@lwn.net>
Cc: SeongJae Park <sj@kernel.org>,
	Jinwoo Park <pmnxis@gmail.com>,
	Austin Kim <austindh.kim@gmail.com>,
	shjy180909@gmail.com,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yunseong Kim <yskelg@gmail.com>
Subject: [PATCH v4] Documentation: cve Korean translation
Date: Tue,  4 Jun 2024 01:15:31 +0900
Message-Id: <20240603161530.80789-1-yskelg@gmail.com>
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

The following changes have been updated based on SeongJae Park’s feedback
and Austin Kim’s from the last v2 and v3 patches.

Signed-off-by: Yunseong Kim <yskelg@gmail.com>
---
 Documentation/translations/ko_KR/index.rst    |   2 +-
 .../translations/ko_KR/process/cve.rst        | 119 +++++++++---------
 2 files changed, 61 insertions(+), 60 deletions(-)

diff --git a/Documentation/translations/ko_KR/index.rst b/Documentation/translations/ko_KR/index.rst
index 4add6b2fe1f2..f38f0ce19a1e 100644
--- a/Documentation/translations/ko_KR/index.rst
+++ b/Documentation/translations/ko_KR/index.rst
@@ -12,7 +12,7 @@
    :maxdepth: 1
 
    howto
-
+   process/cve
 
 리눅스 커널 메모리 배리어
 -------------------------
diff --git a/Documentation/translations/ko_KR/process/cve.rst b/Documentation/translations/ko_KR/process/cve.rst
index 94610c177f17..5a84d0d4266f 100644
--- a/Documentation/translations/ko_KR/process/cve.rst
+++ b/Documentation/translations/ko_KR/process/cve.rst
@@ -1,7 +1,9 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-:Original: Documentation/process/cve.rst
-:Translator: Yunseong Kim <yskelg@gmail.com>
+:원문: Documentation/process/cve.rst
+:역자: 김윤성 <yskelg@gmail.com>
+:감수: 박진우 <pmnxis@gmail.com>, 박성재 <sj@kernel.org>,
+       김동현 <austindh.kim@gmail.com>
 
 ==========
 CVE 항목들
@@ -16,92 +18,91 @@ CVE 항목들
 지속적인 남용이 결합되면서 커널 커뮤니티가 이러한 할당에 대한 통제권을 가져야
 한다는 것이 분명해졌습니다.
 
-Linux 커널 개발자 팀은 잠재적인 Linux 커널 보안 문제에 대해 CVE를 할당할 수
-있는 권한이 있습니다. 여기서 할당은 :doc:`일반 Linux 커널 보안 버그 보고
-절차<../process/security-bugs>`와는 별개입니다.
+Linux 커널 개발팀은 잠재적인 Linux 커널 보안 문제에 대해 CVE를 할당할 수
+있는 권한이 있습니다. 여기서 할당은
+:doc:`일반 Linux 커널 보안 버그 보고절차</process/security-bugs>`와는
+별개입니다.
 
 Linux 커널에 할당된 모든 CVE 목록은
 https://lore.kernel.org/linux-cve-announce/ 에 있는 Linux-CVE 메일링 리스트의
-아카이브에서 확인할 수 있습니다. 할당된 CVE에 대한 알림을 받으려면 다음의
-메일링 리스트를 `구독
-<https://subspace.kernel.org/subscribing.html>`_ 하세요.
+아카이브에서 확인할 수 있습니다. 할당된 CVE에 대한 알림을 받으려면 다음 메일링
+리스트를 `구독<https://subspace.kernel.org/subscribing.html>`_ 하세요.
 
 절차
 ====
 
 일반적인 안정 릴리스 절차의 일부로, 잠재적으로 보안 문제가 될 수 있는 커널
-변경 사항은 CVE 번호 할당을 담당하는 개발자가 식별하여 CVE 번호를 자동으로
+변경 사항은 CVE 번호 할당 담당을 하는 개발자가 식별하여 CVE 번호를 자동으로
 할당합니다. 이러한 할당은 linux-cve-announce 메일링 리스트에 공지사항으로
 수시로 게시됩니다.
 
-리눅스 커널이 시스템에 있는 계층으로 인해 거의 모든 버그가 커널의 보안을
-손상시키는 데 악용될 수 있지만 버그가 수정되면 악용 가능성이 명확하게 드러나지
-않는 경우가 많습니다. 이 때문에 CVE 할당 팀은 지나치게 조심스럽게 버그 수정이
-확인되는 모든 버그에 CVE 번호를 할당합니다.
-이것이 리눅스 커널 팀에서 발행하는 겉으로 보기에 많은 수의 CVE를 설명합니다.
+리눅스 커널은 시스템의 최하단 계층에서 동작합니다. 때문에 거의 모든 버그가
+커널 보안을 취약하게 만들 수 있습니다. 하지만 버그를 수정할 때 악용 가능성을
+명확하게 파악하기 힘든 경우가 많습니다. 이 때문에 CVE 할당 팀은 지나치게
+조심스러워 보일 수도 있는 방식으로 버그 수정이 확인되는 모든 버그에 CVE 번호를
+할당합니다. 이것이 리눅스 커널 팀이 발행한 많은 수의 CVE를 설명합니다.
 
 사용자가 CVE를 지정해야 한다고 생각하는 특정 수정 사항을 CVE 할당 팀이 놓친
 경우에는 <cve@kernel.org>로 이메일을 보내 주시면 커널 CVE 할당 팀에서 함께
 작업할 것입니다. 이 별칭은 이미 릴리스된 커널 트리에 있는 수정 사항에 대한
-CVE 할당 전용이므로 잠재적인 보안 문제는 이 별칭으로 보내서는 안 됩니다.
-수정되지 않은 보안 문제를 발견했다고 생각되면 :doc:`일반 Linux 커널 보안
-버그 보고 절차<../process/security-bugs>`를 따르세요.
+CVE 할당 전용이므로 잠재적인 보안 문제는 이 메일 주소로 보내서는 안 됩니다.
+수정되지 않은 보안 문제를 발견했다고 생각되면
+:doc:`일반 Linux 커널 보안 버그 보고 절차</process/security-bugs>`를 따르세요.
 
 Linux 커널에서 수정되지 않은 보안 이슈에 대해서는 CVE가 자동으로 할당되지
-않으며, 수정이 제공되고 안정적인 커널 트리에 적용된 후에만 자동으로 할당되며,
+않으며, 수정이 제공되고 stable 커널 트리에 적용된 후에만 자동으로 할당되며,
 기존 수정의 git 커밋 ID로 추적할 수 있습니다. 커밋으로 문제가 해결되기 전에
 CVE를 할당받고자 하는 사람은 커널 CVE 할당 팀<cve@kernel.org>에 문의하여
 예약된 식별자 항목들에서 식별자를 할당받으시기 바랍니다.
 
-현재 Stable/LTS 커널 팀에서 적극적으로 지원하지 않는 커널 버전에서 발견된
-문제에 대해서는 CVE가 할당되지 않습니다.
-현재 지원되는 커널 브랜치 목록은 https://kernel.org/releases.html 에서 확인할
-수 있습니다.
+현재 Stable/LTS 커널 팀에서 지원하지 않는 커널 버전에서 발견된 문제에 대해서는
+CVE가 할당되지 않습니다. 현재 지원되는 커널 브랜치 목록은
+https://kernel.org/releases.html 에서 확인할 수 있습니다.
 
-할당된 CVE 항목들의 분쟁
-=========================
+CVE 항목들 할당 분쟁
+====================
 
-특정 커널 변경에 대해 할당된 CVE에 대해 이의를 제기하거나 수정할 권한은
-전적으로 영향을 받는 관련 하위 시스템의 유지 관리자에게 있습니다.
-이 원칙은 취약점 보고에 있어 높은 수준의 정확성과 책임성을 보장합니다.
-하위 시스템에 대한 깊은 전문 지식과 친밀한 지식을 갖춘 사람만이 보고된
-취약점의 유효성과 범위를 효과적으로 평가하고 적절한 CVE 지정을 결정할 수
-있습니다. 이 지정된 기관 외부에서 CVE를 수정하거나 이의를 제기하려는 시도는
-혼란, 부정확한 보고, 궁극적으로 시스템 손상으로 이어질 수 있습니다.
+리눅스 커널 변경 사항에 할당된 CVE에 이의를 제기하거나 수정할 권한은 영향을
+받는 관련 하위 시스템의 관리자에게만 있습니다. 이 원칙은 취약점 보고의 정확성
+및 책임감을 높이기 위해 존재합니다. 하위 시스템에 대한 깊은 전문 지식과 정확한
+이해를 가진 사람만이 보고된 취약점의 유효성과 범위를 효과적으로 판단하고
+적절한 CVE를 지정할 수 있습니다. 지정된 권한 외의 다른 사람이 CVE를 수정 또는
+이의를 제기하려고 시도하면 혼란, 부정확한 보고, 그리고 궁극적으로는 시스템
+손상으로 이어질 수 있습니다.
 
-잘못된 CVE 항목들
-=================
+유효하지 않은 CVE 항목들
+========================
 
-특정 배포판에서 변경된 사항 적용한 배포판은 더 이상 kernel.org 지원 릴리스가
-아닌 커널 버전을 지원합니다. 때문에 Linux 배포판에서만 지원되는 Linux 커널에서
-보안 문제가 발견되는 경우 Linux 커널 CVE 팀에서 CVE를 할당할 수 없습니다.
-변경된 사항을 적용한 특정 Linux 배포판 자체에 요청해야 합니다.
+개별 배포판에서만 지원되는 커널 버전의 보안 문제가 발견된 경우, 또는 개별
+배포판에서 더 이상 kernel.org에서 지원하지 않는 커널 버전을 지원하고 있는
+경우라면, 보안 문제가 발생하는 경우에 Linux 커널 CVE 팀에서 CVE를 할당할 수
+없습니다. 변경된 사항을 적용한 개별 Linux 배포판에 직접 요청해야 합니다.
 
-커널 할당 CVE 팀이 아닌 다른 그룹에서 적극적으로 지원되는 커널 버전에 대해
-Linux 커널에 대해 할당된 CVE는 유효한 CVE로 취급해서는 안 됩니다.
-CNA 수정 절차를 통해 특정 배포판에서 적용한 항목을 무효화할 수 있도록
-커널 CVE 할당 팀<cve@kernel.org>으로 알려주시기 바랍니다.
+적극적으로 지원되고 있는 커널 버전에 대해 리눅스 커널 CVE 팀 외의 다른 그룹이
+CVE를 할당했다면, 이 CVE는 유효하지 않습니다. CNA 수정 절차를 통해 특정
+배포판에서 적용한 항목을 무효화할 수 있도록 커널 CVE 할당 팀<cve@kernel.org>에
+이메일을 통해 알려주시기 바랍니다.
 
-특정 CVE의 적용 가능성
-======================
+특정 CVE의 적용 범위
+====================
 
-Linux 커널은 외부 사용자가 다양한 방법으로 접근하거나 전혀 접근하지 않는
-등 다양한 방식으로 사용될 수 있으므로 특정 CVE의 적용 여부는 Linux 사용자가
-결정할 사항이며 CVE 할당 팀의 권한이 아닙니다. 특정 CVE의 적용 가능성을
-판단하기 위해 우리에게 문의하지 마시기 바랍니다.
+리눅스 커널은 다양한 방식으로 사용될 수 있으며, 외부 사용자가 커널에 접근하는
+방법도 여러 가지이며, 전혀 접근하지 않을 수도 있습니다. 따라서 특정 CVE의 적용
+범위는 리눅스 사용자가 결정해야 합니다. CVE 할당 팀은 이를 판단해줄 수
+없습니다. 특정 CVE의 적용 범위를 확인하기 위해 우리 팀에 문의하지 않기를
+바랍니다.
 
-또한 소스 트리가 매우 방대하고 어떤 시스템도 소스 트리의 작은 하위 집합만
-사용하므로 Linux 사용자는 할당된 많은 수의 CVE가 자신의 시스템과 관련이 없다는
-사실을 알고 인지해야 합니다.
+또한 소스 트리는 매우 방대하고, 각 시스템은 소스 트리의 일부분만을 사용하기
+때문에 많은 사용자들이 할당된 CVE 중 상당 부분이 자신의 시스템과 관련이 없다는
+사실을 인지해야 합니다.
 
 즉, 우리는 사용자의 사용 사례를 알지 못하며 사용자가 커널의 어떤 부분을
 사용하는지 알 수 없으므로 특정 CVE가 사용자의 시스템과 관련이 있는지 판단할 수
-있는 방법이 없습니다.
-
-항상 그렇듯이 커널 변경 사항은 개별적으로 선별된 변경 사항이 아니라 많은
-커뮤니티 구성원이 통합된 전체에서 함께 테스트하는 것이므로 릴리스된 모든 커널
-변경 사항을 적용하는 것이 가장 좋습니다. 또한 많은 버그의 경우 전체 문제에
-대한 해결책은 단일 변경 사항이 아니라 여러 수정 사항을 모아놓고 보아야 찾을 수
-있다는 점에 유의하세요. 이상적으로는 모든 문제에 대한 모든 수정 사항에 CVE가
-할당되지만, 때로는 수정 사항을 발견하지 못하는 경우가 있으므로 CVE가 할당되지
-않은 일부 변경 사항이 관련성이 있을 수 있다고 가정합니다.
+없습니다.
+
+여태까지 항상 그래왔듯이, 커뮤니티 구성원들의 통합된 테스트를 거친 전체 커널
+변경 사항을 적용하는 것이 좋습니다. 개별적인 부분만 선택하여 적용하는 것을
+권장하지 않습니다. 또한 많은 버그의 경우 전체적인 문제 해결은 단일 변경 사항이
+아니라 여러 수정 사항의 누적을 통해 이루어집니다. 이상적으로는 모든 문제에
+대한 모든 수정 사항에 CVE가 할당되지만, 때로는 누락될 수도 있습니다. 따라서
+CVE가 할당되지 않은 일부 변경 사항도 시스템에 적용하는 것이 중요할 수 있습니다.
-- 
2.34.1


